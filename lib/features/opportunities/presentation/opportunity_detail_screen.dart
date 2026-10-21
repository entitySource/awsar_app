import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/opportunity_type_label.dart';
import 'widgets/sample_chip.dart';
import 'widgets/save_button.dart';

class OpportunityDetailScreen extends ConsumerWidget {
  const OpportunityDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final content = ref.watch(contentProvider);
    final o = content.value?.opportunityById(id);
    final applyUri = o?.applyUrl == null ? null : Uri.tryParse(o!.applyUrl!);
    final locale = Localizations.localeOf(context).toLanguageTag();

    return PageScaffold(
      title: o == null ? l10n.opportunitiesTitle : opportunityTypeLabel(l10n, o.type),
      bottomBar: applyUri == null
          ? null
          : BottomActionBar(
              child: Row(
                children: [
                  SaveOpportunityButton(id: id),
                  const SizedBox(width: Gap.sm),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => openLink(context, ref, applyUri),
                      icon: const Icon(Icons.open_in_new),
                      label: Text(l10n.oppApply),
                    ),
                  ),
                ],
              ),
            ),
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final o = c.opportunityById(id);
          if (o == null) {
            return EmptyState(
              icon: Icons.search_off,
              title: l10n.oppNoResults,
              body: l10n.oppNoResultsBody,
              actionLabel: l10n.opportunitiesTitle,
              onAction: () => context.go(Routes.opportunities),
            );
          }
          final rows = <(String, String)>[
            if (o.provider != null) (l10n.oppProvider, o.provider!),
            if (o.eligibility != null) (l10n.oppEligibility, o.eligibility!),
            if (o.amount != null) (l10n.oppAmount, o.amount!),
            if (o.deadline != null) (l10n.oppDeadline, DateFormat.yMMMMd(locale).format(o.deadline!)),
            if (o.location != null) (l10n.oppLocation, o.location!),
            if (o.mode != null) (l10n.oppMode, o.mode!),
          ];
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              const SizedBox(height: Gap.sm),
              Wrap(
                spacing: Gap.sm,
                runSpacing: Gap.xs,
                children: [if (o.sample) const SampleChip(), if (c.meta.draft) const DraftBadge()],
              ),
              const SizedBox(height: Gap.sm),
              Semantics(header: true, child: Text(o.title, style: theme.textTheme.headlineSmall)),
              const SizedBox(height: Gap.md),
              Text(o.summary, style: theme.textTheme.bodyLarge),
              const SizedBox(height: Gap.lg),
              for (final (label, value) in rows)
                MergeSemantics(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Gap.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        Text(value, style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              if (o.tags.isNotEmpty)
                Wrap(
                  spacing: Gap.sm,
                  runSpacing: Gap.sm,
                  children: [for (final t in o.tags) Chip(label: Text(t))],
                ),
              SourceFooter(url: o.sourceUrl),
            ],
          );
        },
      ),
    );
  }
}
