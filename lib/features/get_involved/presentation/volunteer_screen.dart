import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/content/models/get_involved_info.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/form_error_hint.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/handoff_builder.dart';
import '../domain/validators.dart';
import 'widgets/field_error_text.dart';
import 'widgets/reveal_first_error.dart';

class VolunteerScreen extends ConsumerStatefulWidget {
  const VolunteerScreen({super.key});

  @override
  ConsumerState<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends ConsumerState<VolunteerScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _message = TextEditingController();
  String? _interest;
  var _committed = false;
  var _autovalidate = AutovalidateMode.disabled;
  var _showFixHint = false;

  var _prefilled = false;

  @override
  void initState() {
    super.initState();
    // Signed in: start from the details given at sign-up.
    final user = ref.read(authControllerProvider);
    if (user != null) {
      _name.text = user.fullName ?? '';
      _email.text = user.email;
      _phone.text = user.phone ?? '';
      _prefilled = true;
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _email, _phone, _message]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit(VolunteerInfo info) async {
    final l10n = AppLocalizations.of(context);
    if (!validateAndRevealFirstError(_form.currentState!)) {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
        _showFixHint = true;
      });
      return;
    }
    final to = info.handoffEmail;
    if (to == null) {
      if (info.formUrl != null) await openLink(context, ref, Uri.parse(info.formUrl!));
      return;
    }
    if (_showFixHint) setState(() => _showFixHint = false);
    HapticFeedback.lightImpact();
    final uri = volunteerEmail(
      to: to,
      subject: l10n.emailSubjectVolunteer(_name.text.trim()),
      v: VolunteerDetails(
        name: _name.text,
        email: _email.text,
        phone: _phone.text,
        interest: _interest ?? info.interestAreas.firstOrNull ?? '',
        hoursPerWeek: info.minHoursPerWeek,
        weeks: info.minWeeks,
        message: _message.text,
      ),
    );
    final ok = await openLink(context, ref, uri);
    if (ok && mounted) context.go(Routes.handoffSent);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final content = ref.watch(contentProvider);
    final info = content.value?.volunteer;
    String? err(FieldError? e) => fieldErrorText(l10n, e);

    return PageScaffold(
      title: l10n.volunteerTitle,
      bottomBar: info == null
          ? null
          : BottomActionBar(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_showFixHint && _committed) FormErrorHint(l10n.errFixFields),
                  if (!_committed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: Gap.sm),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 16, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(width: Gap.xs),
                          Expanded(child: Text(l10n.volunteerCommitRequired, style: theme.textTheme.bodySmall)),
                        ],
                      ),
                    ),
                  FilledButton.icon(
                    key: const Key('volunteer-submit'),
                    onPressed: _committed ? () => _submit(info) : null,
                    icon: const Icon(Icons.send),
                    label: Text(l10n.volunteerSubmit),
                  ),
                ],
              ),
            ),
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final info = c.volunteer;
          return Form(
            key: _form,
            autovalidateMode: _autovalidate,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
              children: [
                const SizedBox(height: Gap.sm),
                for (final p in info.intro)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Gap.sm),
                    child: Text(p, style: theme.textTheme.bodyLarge),
                  ),
                Text(info.commitmentText, style: theme.textTheme.titleMedium),
                if (c.meta.draft) const DraftBadge(),
                if (_prefilled) ...[
                  const SizedBox(height: Gap.sm),
                  Row(
                    key: const Key('prefilled-note'),
                    children: [
                      Icon(Icons.person_outline, size: 18, color: theme.colorScheme.primary),
                      const SizedBox(width: Gap.xs),
                      Expanded(child: Text(l10n.prefilledNote, style: theme.textTheme.bodySmall)),
                    ],
                  ),
                ],
                const SizedBox(height: Gap.lg),
                TextFormField(
                  controller: _name,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autofillHints: const [AutofillHints.name],
                  decoration: InputDecoration(labelText: '${l10n.fieldName} *'),
                  validator: (v) => err(validateRequired(v)),
                ),
                const SizedBox(height: Gap.lg),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  decoration: InputDecoration(labelText: '${l10n.fieldEmail} *'),
                  validator: (v) => err(validateEmail(v)),
                ),
                const SizedBox(height: Gap.lg),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  decoration: InputDecoration(labelText: '${l10n.fieldPhone} *', prefixText: '+91 '),
                  validator: (v) => err(validateIndianMobile(v)),
                ),
                const SizedBox(height: Gap.lg),
                DropdownButtonFormField<String>(
                  initialValue: _interest ?? info.interestAreas.firstOrNull,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l10n.fieldInterest),
                  items: [
                    for (final a in info.interestAreas)
                      DropdownMenuItem(
                        value: a,
                        child: Text(a, overflow: TextOverflow.ellipsis),
                      ),
                  ],
                  onChanged: (v) => setState(() => _interest = v),
                ),
                const SizedBox(height: Gap.lg),
                TextFormField(
                  controller: _message,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(labelText: l10n.fieldMessage, alignLabelWithHint: true),
                ),
                const SizedBox(height: Gap.md),
                CheckboxListTile(
                  key: const Key('volunteer-commit'),
                  value: _committed,
                  onChanged: (v) => setState(() => _committed = v ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.volunteerCommitCheck(info.minHoursPerWeek, info.minWeeks)),
                ),
                SourceFooter(url: info.sourceUrl),
              ],
            ),
          );
        },
      ),
    );
  }
}
