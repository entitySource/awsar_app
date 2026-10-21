import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../core/links/open_link.dart';
import '../../../../l10n/app_localizations.dart';

/// Bottom sheet that hands the user off to email, the website or Give.do.
/// The app never takes payments itself.
Future<void> showHandoffSheet(BuildContext context, {required Uri? email, required Uri website, Uri? giveDo}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) => _HandoffSheet(email: email, website: website, giveDo: giveDo, parent: context),
  );
}

class _HandoffSheet extends ConsumerWidget {
  const _HandoffSheet({required this.email, required this.website, required this.giveDo, required this.parent});

  final Uri? email;
  final Uri website;
  final Uri? giveDo;
  final BuildContext parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Gap.xl, 0, Gap.xl, Gap.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(header: true, child: Text(l10n.handoffTitle, style: theme.textTheme.titleLarge)),
            const SizedBox(height: Gap.sm),
            Text(l10n.handoffBody, style: theme.textTheme.bodyMedium),
            const SizedBox(height: Gap.xl),
            if (email != null) ...[
              FilledButton.icon(
                key: const Key('handoff-email'),
                style: ctaButtonStyle(theme.colorScheme),
                onPressed: () async {
                  final ok = await openLink(context, ref, email!);
                  if (ok && context.mounted) {
                    Navigator.of(context).pop();
                    if (parent.mounted) parent.go(Routes.handoffSent);
                  }
                },
                icon: const Icon(Icons.mail_outline),
                label: Text(l10n.handoffEmail),
              ),
              const SizedBox(height: Gap.xs),
              Text(
                l10n.handoffEmailHint,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: Gap.md),
            ],
            if (giveDo != null) ...[
              OutlinedButton.icon(
                onPressed: () => openLink(context, ref, giveDo!),
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.handoffGiveDo),
              ),
              const SizedBox(height: Gap.md),
            ],
            OutlinedButton.icon(
              onPressed: () => openLink(context, ref, website),
              icon: const Icon(Icons.public),
              label: Text(l10n.handoffWebsite),
            ),
            const SizedBox(height: Gap.lg),
            Row(
              children: [
                Icon(Icons.wifi, size: 16, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: Gap.xs),
                Expanded(child: Text(l10n.handoffNoNetworkNote, style: theme.textTheme.bodySmall)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
