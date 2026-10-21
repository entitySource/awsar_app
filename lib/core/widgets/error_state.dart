import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'empty_state.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: Icons.error_outline,
      title: l10n.errorTitle,
      body: l10n.errorBody,
      actionLabel: l10n.retry,
      onAction: onRetry,
    );
  }
}
