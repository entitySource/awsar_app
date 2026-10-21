import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';

class GetInvolvedScreen extends ConsumerWidget {
  const GetInvolvedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return PageScaffold(
      title: l10n.getInvolvedTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
          children: [
            const SizedBox(height: Gap.sm),
            Text(
              l10n.getInvolvedSubtitle,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: Gap.lg),
            _ActionCard(
              key: const Key('gi-donate-india'),
              icon: Icons.favorite,
              title: l10n.donateIndiaTitle,
              subtitle: l10n.donateIndiaSubtitle,
              emphasised: true,
              onTap: () => context.go(Routes.donateIndia),
            ),
            const SizedBox(height: Gap.md),
            _ActionCard(
              icon: Icons.public,
              title: l10n.donateIntlTitle,
              subtitle: l10n.donateIntlSubtitle,
              onTap: () => context.go(Routes.donateIntl),
            ),
            const SizedBox(height: Gap.md),
            _ActionCard(
              key: const Key('gi-volunteer'),
              icon: Icons.handshake_outlined,
              title: l10n.volunteerTitle,
              subtitle: l10n.volunteerSubtitle(c.volunteer.minHoursPerWeek, c.volunteer.minWeeks),
              onTap: () => context.go(Routes.volunteer),
            ),
            SourceFooter(url: c.donate.sourceUrl),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.emphasised = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bg = emphasised ? scheme.primaryContainer : scheme.surfaceContainerLow;
    final fg = emphasised ? scheme.onPrimaryContainer : scheme.onSurface;
    return Card(
      color: bg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Gap.lg),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Icon(icon, color: emphasised ? scheme.primary : scheme.onSurfaceVariant, size: 28),
              ),
              const SizedBox(width: Gap.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium?.copyWith(color: fg)),
                    const SizedBox(height: Gap.xs),
                    Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: fg)),
                  ],
                ),
              ),
              ExcludeSemantics(child: Icon(Icons.chevron_right, color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
