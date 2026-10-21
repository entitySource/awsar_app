import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/auth/auth_providers.dart';
import '../../../core/auth/auth_repository.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/form_error_hint.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../l10n/app_localizations.dart';
import '../../get_involved/domain/validators.dart';
import '../../get_involved/presentation/widgets/field_error_text.dart';
import '../../get_involved/presentation/widgets/reveal_first_error.dart';

/// Sign in, create an account, or see what the account does and sign out.
class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  var _creating = false;
  var _obscure = true;
  var _busy = false;
  var _autovalidate = AutovalidateMode.disabled;
  AuthFailure? _failure;
  var _checkEmail = false;

  @override
  void dispose() {
    for (final c in [_name, _phone, _email, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    if (!validateAndRevealFirstError(_form.currentState!)) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    setState(() {
      _busy = true;
      _failure = null;
      _checkEmail = false;
    });
    final auth = ref.read(authControllerProvider.notifier);
    final result = _creating
        ? await auth.signUp(email: _email.text, password: _password.text, fullName: _name.text, phone: _phone.text)
        : await auth.signIn(_email.text, _password.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      switch (result) {
        case AuthSignedIn():
          HapticFeedback.lightImpact();
          _password.clear();
        case AuthNeedsConfirmation():
          _checkEmail = true;
          _creating = false;
          _password.clear();
        case AuthFailed(:final failure):
          _failure = failure;
      }
    });
  }

  Future<void> _signOut() async {
    final messenger = ScaffoldMessenger.of(context);
    final done = AppLocalizations.of(context).accountSignedOutToast;
    await ref.read(authControllerProvider.notifier).signOut();
    messenger.showSnackBar(SnackBar(content: Text(done)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final configured = ref.watch(authRepositoryProvider).isConfigured;
    final user = ref.watch(authControllerProvider);

    if (!configured) {
      return PageScaffold(
        title: l10n.accountTitle,
        body: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: l10n.accountNotConfiguredTitle,
          body: l10n.accountNotConfiguredBody,
        ),
      );
    }
    if (user != null) return _SignedIn(user: user, onSignOut: _signOut);

    final theme = Theme.of(context);
    String? err(FieldError? e) => fieldErrorText(l10n, e);

    return PageScaffold(
      title: l10n.accountTitle,
      bottomBar: BottomActionBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_failure != null) FormErrorHint(authFailureText(l10n, _failure!)),
            FilledButton(
              key: const Key('account-submit'),
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(_creating ? l10n.accountCreate : l10n.accountSignIn),
            ),
          ],
        ),
      ),
      body: Form(
        key: _form,
        autovalidateMode: _autovalidate,
        child: AutofillGroup(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              const SizedBox(height: Gap.sm),
              SegmentedButton<bool>(
                key: const Key('account-mode'),
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(value: false, label: Text(l10n.accountSignIn)),
                  ButtonSegment(value: true, label: Text(l10n.accountCreate)),
                ],
                selected: {_creating},
                onSelectionChanged: (s) => setState(() {
                  _creating = s.first;
                  _failure = null;
                  _autovalidate = AutovalidateMode.disabled;
                }),
              ),
              const SizedBox(height: Gap.lg),
              Text(
                l10n.accountSignedOutHint,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              if (_checkEmail) ...[
                const SizedBox(height: Gap.lg),
                Semantics(
                  liveRegion: true,
                  child: Card(
                    key: const Key('account-check-email'),
                    color: theme.colorScheme.secondaryContainer,
                    child: ListTile(
                      leading: const Icon(Icons.mark_email_unread_outlined),
                      title: Text(l10n.accountCheckEmail),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: Gap.xl),
              if (_creating) ...[
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
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  decoration: InputDecoration(labelText: '${l10n.fieldPhone} *', prefixText: '+91 '),
                  validator: (v) => err(validateIndianMobile(v)),
                ),
                const SizedBox(height: Gap.lg),
              ],
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(labelText: '${l10n.fieldEmail} *'),
                validator: (v) => err(validateEmail(v)),
              ),
              const SizedBox(height: Gap.lg),
              TextFormField(
                controller: _password,
                obscureText: _obscure,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                autofillHints: [_creating ? AutofillHints.newPassword : AutofillHints.password],
                onFieldSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: '${l10n.fieldPassword} *',
                  helperText: _creating ? l10n.fieldPasswordHelper : null,
                  suffixIcon: IconButton(
                    tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                    icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (v) => err(_creating ? validatePassword(v) : validateRequired(v)),
              ),
              const SizedBox(height: Gap.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignedIn extends StatelessWidget {
  const _SignedIn({required this.user, required this.onSignOut});

  final AppUser user;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final name = user.fullName?.trim();
    return PageScaffold(
      title: l10n.accountTitle,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
        children: [
          const SizedBox(height: Gap.sm),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                child: const Icon(Icons.person_outline),
              ),
              title: Text(name == null || name.isEmpty ? user.email : name),
              subtitle: Text(l10n.accountSignedInAs(user.email)),
            ),
          ),
          SectionHeader(l10n.accountUnlocks),
          for (final t in [l10n.accountUnlockSaved, l10n.accountUnlockPrefill])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_outline, color: theme.colorScheme.primary),
              title: Text(t),
            ),
          const SizedBox(height: Gap.xl),
          OutlinedButton.icon(
            key: const Key('account-signout'),
            onPressed: onSignOut,
            icon: const Icon(Icons.logout),
            label: Text(l10n.accountSignOut),
          ),
          const SizedBox(height: Gap.xxl),
        ],
      ),
    );
  }
}

String authFailureText(AppLocalizations l10n, AuthFailure f) => switch (f) {
  AuthFailure.invalidCredentials => l10n.authErrInvalid,
  AuthFailure.emailInUse => l10n.authErrEmailInUse,
  AuthFailure.weakPassword => l10n.authErrWeak,
  AuthFailure.emailNotConfirmed => l10n.authErrNotConfirmed,
  AuthFailure.network => l10n.authErrNetwork,
  AuthFailure.notConfigured => l10n.accountNotConfiguredTitle,
  AuthFailure.unknown => l10n.authErrUnknown,
};
