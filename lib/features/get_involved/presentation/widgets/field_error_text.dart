import '../../../../l10n/app_localizations.dart';
import '../../domain/validators.dart';

String? fieldErrorText(AppLocalizations l10n, FieldError? e) => switch (e) {
  null => null,
  FieldError.required => l10n.errRequired,
  FieldError.email => l10n.errEmail,
  FieldError.phone => l10n.errPhone,
  FieldError.amount => l10n.errAmount,
  FieldError.pan => l10n.errPan,
  FieldError.password => l10n.errPassword,
};
