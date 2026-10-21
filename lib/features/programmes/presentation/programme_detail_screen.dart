import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/impact_stat.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/programme_icon.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';

class ProgrammeDetailScreen extends ConsumerWidget {
  const ProgrammeDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final content = ref.watch(contentProvider);
    final programme = content.value?.programmeById(id);
    return PageScaffold(
      title: l10n.programmesTitle,
      bottomBar: programme == null
          ? null
          : BottomActionBar(
              child: FilledButton.icon(
                onPressed: () => context.go(Routes.donateIndia),
                style: ctaButtonStyle(theme.colorScheme),
                icon: const Icon(Icons.favorite),
                label: Text(l10n.programmeSupportCta),
              ),
            ),
      body: AsyncValueView(
        value: content,
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final p = c.programmeById(id);
          if (p == null) {
            return EmptyState(
              icon: Icons.search_off,
              title: l10n.errorTitle,
              body: l10n.programmeNoDetail,
              actionLabel: l10n.programmesTitle,
              onAction: () => context.go(Routes.programmes),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              const SizedBox(height: Gap.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'programme-icon-${p.id}',
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(programmeIcon(p.icon), size: 28, color: theme.colorScheme.onSecondaryContainer),
                    ),
                  ),
                  const SizedBox(width: Gap.lg),
                  Expanded(
                    child: Semantics(header: true, child: Text(p.title, style: theme.textTheme.headlineSmall)),
                  ),
                ],
              ),
              if (c.meta.draft) const DraftBadge(),
              const SizedBox(height: Gap.lg),
              Text(p.summary, style: theme.textTheme.bodyLarge),
              if (p.impact.isNotEmpty) ...[SectionHeader(l10n.programmeImpact), ImpactGrid(stats: p.impact)],
              SectionHeader(l10n.programmeAbout),
              if (p.body.isEmpty)
                Text(
                  l10n.programmeNoDetail,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                )
              else
                for (final para in p.body)
                  Padding(
                    padding: const EdgeInsets.only(bottom: Gap.md),
                    child: Text(para, style: theme.textTheme.bodyLarge),
                  ),
              SourceFooter(url: p.sourceUrl),
            ],
          );
        },
      ),
    );
  }
}
