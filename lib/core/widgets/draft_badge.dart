import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../l10n/app_localizations.dart';

/// Marks machine-assisted Hindi content. Long-press shows why.
class DraftBadge extends StatelessWidget {
  const DraftBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: l10n.draftBadgeHint,
      triggerMode: TooltipTriggerMode.tap,
      child: Semantics(
        label: '${l10n.draftBadge}. ${l10n.draftBadgeHint}',
        excludeSemantics: true,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Gap.sm, vertical: Gap.xs),
              decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.translate, size: 16, color: scheme.onSecondaryContainer),
                  const SizedBox(width: Gap.xs),
                  Flexible(
                    child: Text(
                      l10n.draftBadge,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: scheme.onSecondaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
