import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/content/models/get_involved_info.dart';
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
import 'donate_pay_screen.dart';
import 'widgets/handoff_sheet.dart';

class DonateIndiaScreen extends ConsumerStatefulWidget {
  const DonateIndiaScreen({super.key});

  @override
  ConsumerState<DonateIndiaScreen> createState() => _DonateIndiaScreenState();
}

class _DonateIndiaScreenState extends ConsumerState<DonateIndiaScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _amount = TextEditingController();
  // PAN stays in this controller and the outgoing email only; never saved.
  final _pan = TextEditingController();
  String? _payment;
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
    for (final c in [_name, _email, _phone, _amount, _pan]) {
      c.dispose();
    }
    super.dispose();
  }

  void _continue(DonateInfo info) {
    final l10n = AppLocalizations.of(context);
    if (!validateAndRevealFirstError(_form.currentState!)) {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
        _showFixHint = true;
      });
      return;
    }
    if (_showFixHint) setState(() => _showFixHint = false);
    HapticFeedback.lightImpact();
    final details = DonationDetails(
      name: _name.text,
      email: _email.text,
      phone: _phone.text,
      amount: _amount.text,
      paymentPreference: _payment ?? info.paymentPreferences.first,
      pan: _pan.text,
    );
    // A UPI QR when the content has a payee; otherwise the email hand-off.
    final upi = info.upi;
    if (upi != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DonatePayScreen(upi: upi, details: details, receiptEmail: info.handoffEmail),
        ),
      );
      return;
    }
    showHandoffSheet(
      context,
      email: info.handoffEmail == null
          ? null
          : donationEmail(to: info.handoffEmail!, subject: l10n.emailSubjectDonate(details.name.trim()), d: details),
      website: Uri.parse(info.donatePageUrl),
      giveDo: info.giveDoUrl == null ? null : Uri.tryParse(info.giveDoUrl!),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final content = ref.watch(contentProvider);
    final info = content.value?.donate;

    String? err(FieldError? e) => fieldErrorText(l10n, e);

    return PageScaffold(
      title: l10n.donateIndiaTitle,
      bottomBar: info == null
          ? null
          : BottomActionBar(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_showFixHint) FormErrorHint(l10n.errFixFields),
                  FilledButton(
                    key: const Key('donate-continue'),
                    style: ctaButtonStyle(theme.colorScheme),
                    onPressed: () => _continue(info),
                    child: Text(l10n.continueBtn),
                  ),
                ],
              ),
            ),
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final info = c.donate;
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
                TextFormField(
                  controller: _amount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
                  decoration: InputDecoration(labelText: '${l10n.fieldAmount} *', prefixText: '₹ '),
                  validator: (v) => err(validateAmount(v)),
                ),
                const SizedBox(height: Gap.lg),
                DropdownButtonFormField<String>(
                  initialValue: _payment ?? info.paymentPreferences.firstOrNull,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: l10n.fieldPaymentPref),
                  items: [for (final p in info.paymentPreferences) DropdownMenuItem(value: p, child: Text(p))],
                  onChanged: (v) => setState(() => _payment = v),
                ),
                const SizedBox(height: Gap.lg),
                TextFormField(
                  controller: _pan,
                  textCapitalization: TextCapitalization.characters,
                  autocorrect: false,
                  enableSuggestions: false,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))],
                  decoration: InputDecoration(
                    labelText: l10n.fieldPan,
                    helperText: l10n.fieldPanHelper,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (v) => err(validatePanOptional(v)),
                ),
                if (info.taxNote != null) ...[
                  const SizedBox(height: Gap.sm),
                  Text(info.taxNote!, style: theme.textTheme.bodySmall),
                ],
                SourceFooter(url: info.sourceUrl),
              ],
            ),
          );
        },
      ),
    );
  }
}
