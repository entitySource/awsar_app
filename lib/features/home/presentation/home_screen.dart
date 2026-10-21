import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/content/app_content.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/impact_stat.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import '../../programmes/presentation/widgets/programme_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PageScaffold(
      title: l10n.appTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) => _HomeBody(content: c),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.content});

  final AppContent content;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final org = content.org;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
      children: [
        // 1. Hero: who AWSAR is, and the one primary (donate) action.
        const SizedBox(height: Gap.lg),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(width: 40, height: 4, color: scheme.tertiary),
        ),
        const SizedBox(height: Gap.lg),
        Semantics(header: true, child: Text(org.tagline, style: theme.textTheme.displaySmall)),
        const SizedBox(height: Gap.md),
        Text(org.intro, style: theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant)),
        if (content.meta.draft) const DraftBadge(),
        const SizedBox(height: Gap.xl),
        FilledButton.icon(
          key: const Key('home-donate'),
          style: ctaButtonStyle(scheme),
          onPressed: () {
            HapticFeedback.lightImpact();
            context.go(Routes.donateIndia);
          },
          icon: const Icon(Icons.favorite),
          label: Text(l10n.homeDonateCta),
        ),
        const SizedBox(height: Gap.md),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(Routes.volunteer),
                icon: const Icon(Icons.handshake_outlined),
                label: Text(l10n.homeVolunteerCta, maxLines: 2, textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(width: Gap.md),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.go(Routes.opportunities),
                icon: const Icon(Icons.school_outlined),
                label: Text(l10n.homeOpportunitiesCta, maxLines: 2, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
        // 2. Proof: numbers before the asks below.
        SectionHeader(l10n.homeImpact),
        ImpactGrid(stats: org.impact.take(6).toList()),
        // 3. What AWSAR does.
        SectionHeader(l10n.homeMission),
        Text(org.mission, style: theme.textTheme.bodyLarge),
        SectionHeader(l10n.homeOurWork, actionLabel: l10n.homeSeeAll, onAction: () => context.go(Routes.programmes)),
        for (final p in content.programmes.take(3)) ...[ProgrammeCard(programme: p), const SizedBox(height: Gap.md)],
        // 4. Clear path to act, repeated at the end.
        const SizedBox(height: Gap.lg),
        Container(
          padding: const EdgeInsets.all(Gap.xl),
          decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  l10n.homeCtaTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ),
              const SizedBox(height: Gap.sm),
              Text(l10n.homeCtaBody, style: theme.textTheme.bodyLarge?.copyWith(color: scheme.onPrimaryContainer)),
              const SizedBox(height: Gap.lg),
              Wrap(
                spacing: Gap.md,
                runSpacing: Gap.sm,
                children: [
                  FilledButton(onPressed: () => context.go(Routes.getInvolved), child: Text(l10n.getInvolvedTitle)),
                  TextButton(onPressed: () => context.go(Routes.about), child: Text(l10n.homeAboutCta)),
                ],
              ),
            ],
          ),
        ),
        SourceFooter(url: org.sourceUrl),
      ],
    );
  }
}
