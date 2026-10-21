import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../l10n/app_localizations.dart';

/// Shown after the email app opens: what happens next.
class HandoffSentScreen extends StatelessWidget {
  const HandoffSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return PageScaffold(
      title: l10n.getInvolvedTitle,
      body: ListView(
        padding: const EdgeInsets.all(Gap.xl),
        children: [
          ExcludeSemantics(
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(Icons.mark_email_read_outlined, size: 32, color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
          ),
          const SizedBox(height: Gap.xl),
          Semantics(
            header: true,
            liveRegion: true,
            child: Text(l10n.successTitle, style: theme.textTheme.headlineSmall),
          ),
          const SizedBox(height: Gap.md),
          Text(l10n.successBody, style: theme.textTheme.bodyLarge),
          const SizedBox(height: Gap.xl),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(onPressed: () => context.go(Routes.getInvolved), child: Text(l10n.successDone)),
          ),
        ],
      ),
    );
  }
}
