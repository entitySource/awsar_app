import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/content/models/opportunity.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import '../application/opportunity_providers.dart';
import 'widgets/opportunity_card.dart';
import 'widgets/opportunity_type_label.dart';

class OpportunitiesScreen extends ConsumerStatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  ConsumerState<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends ConsumerState<OpportunitiesScreen> {
  late final TextEditingController _search;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController(text: ref.read(opportunityFilterProvider).query);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filter = ref.watch(opportunityFilterProvider);
    final ctrl = ref.read(opportunityFilterProvider.notifier);
    final content = ref.watch(contentProvider);
    final results = ref.watch(filteredOpportunitiesProvider);

    return PageScaffold(
      title: l10n.opportunitiesTitle,
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final items = results.value ?? const <Opportunity>[];
          final anySample = c.opportunities.any((o) => o.sample);
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              const SizedBox(height: Gap.sm),
              Text(c.eduAnchors.tagline, style: theme.textTheme.headlineSmall),
              const SizedBox(height: Gap.xs),
              Text(
                l10n.opportunitiesSubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              if (c.meta.draft) const DraftBadge(),
              const SizedBox(height: Gap.lg),
              TextField(
                controller: _search,
                onChanged: ctrl.setQuery,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: l10n.oppSearchLabel,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: filter.query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.oppSearchClear,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _search.clear();
                            ctrl.setQuery('');
                          },
                        ),
                ),
              ),
              const SizedBox(height: Gap.md),
              Wrap(
                spacing: Gap.sm,
                runSpacing: Gap.sm,
                children: [
                  ChoiceChip(
                    label: Text(l10n.oppFilterAll),
                    selected: filter.type == null,
                    onSelected: (_) => ctrl.setType(null),
                  ),
                  for (final t in OpportunityType.values)
                    ChoiceChip(
                      label: Text(opportunityTypeLabel(l10n, t)),
                      selected: filter.type == t,
                      onSelected: (sel) => ctrl.setType(sel ? t : null),
                    ),
                  FilterChip(
                    avatar: const Icon(Icons.bookmark_outline, size: 18),
                    label: Text(l10n.oppSavedOnly),
                    selected: filter.savedOnly,
                    onSelected: ctrl.setSavedOnly,
                  ),
                ],
              ),
              if (anySample) ...[const SizedBox(height: Gap.md), _Notice(text: l10n.oppSampleNotice)],
              const SizedBox(height: Gap.md),
              if (items.isEmpty)
                filter.savedOnly && filter.type == null && filter.query.isEmpty
                    ? EmptyState(icon: Icons.bookmark_border, title: l10n.oppNoSaved, body: l10n.oppNoSavedBody)
                    : EmptyState(
                        icon: Icons.search_off,
                        title: l10n.oppNoResults,
                        body: l10n.oppNoResultsBody,
                        actionLabel: l10n.oppClearFilters,
                        onAction: () {
                          _search.clear();
                          ctrl.clear();
                        },
                      )
              else
                for (final o in items) ...[OpportunityCard(opportunity: o), const SizedBox(height: Gap.md)],
              SourceFooter(url: c.eduAnchors.sourceUrl),
            ],
          );
        },
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(color: scheme.surfaceContainerHigh, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20, color: scheme.onSurfaceVariant),
          const SizedBox(width: Gap.sm),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
        ],
      ),
    );
  }
}
