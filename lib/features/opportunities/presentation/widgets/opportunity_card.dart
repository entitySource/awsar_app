import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/routes.dart';
import '../../../../app/theme.dart';
import '../../../../core/content/models/opportunity.dart';
import '../../../../l10n/app_localizations.dart';
import 'opportunity_type_label.dart';
import 'sample_chip.dart';
import 'save_button.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({super.key, required this.opportunity});

  final Opportunity opportunity;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final o = opportunity;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      child: InkWell(
        onTap: () => context.go(Routes.opportunity(o.id)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Gap.lg, Gap.lg, Gap.xs, Gap.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: Gap.sm,
                      runSpacing: Gap.xs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(opportunityTypeIcon(o.type), size: 16, color: scheme.primary),
                            const SizedBox(width: Gap.xs),
                            Text(
                              opportunityTypeLabel(l10n, o.type),
                              style: theme.textTheme.labelMedium?.copyWith(color: scheme.primary),
                            ),
                          ],
                        ),
                        if (o.sample) const SampleChip(),
                      ],
                    ),
                    const SizedBox(height: Gap.sm),
                    Text(o.title, style: theme.textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                    if (o.provider != null)
                      Text(o.provider!, style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                    const SizedBox(height: Gap.xs),
                    Text(
                      o.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (o.deadline != null) ...[
                      const SizedBox(height: Gap.sm),
                      Text(
                        '${l10n.oppDeadline}: ${DateFormat.yMMMd(locale).format(o.deadline!)}',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ],
                ),
              ),
              SaveOpportunityButton(id: o.id),
            ],
          ),
        ),
      ),
    );
  }
}
