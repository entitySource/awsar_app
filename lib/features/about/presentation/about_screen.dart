import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return PageScaffold(
      title: l10n.aboutTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          final org = c.org;
          final edu = c.eduAnchors;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              const SizedBox(height: Gap.sm),
              Semantics(header: true, child: Text(org.name, style: theme.textTheme.headlineMedium)),
              Text(org.tagline, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
              if (c.meta.draft) const DraftBadge(),
              if (org.storyLead != null || org.story.isNotEmpty) SectionHeader(l10n.aboutStory),
              if (org.storyLead != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: Gap.md),
                  child: Text(org.storyLead!, style: theme.textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic)),
                ),
              for (final p in org.story)
                Padding(
                  padding: const EdgeInsets.only(bottom: Gap.md),
                  child: Text(p, style: theme.textTheme.bodyLarge),
                ),
              SectionHeader(l10n.aboutVision),
              Text(org.vision, style: theme.textTheme.bodyLarge),
              SectionHeader(l10n.aboutMission),
              Text(org.mission, style: theme.textTheme.bodyLarge),
              if (org.values.isNotEmpty) ...[
                SectionHeader(l10n.aboutValues),
                Wrap(
                  spacing: Gap.sm,
                  runSpacing: Gap.sm,
                  children: [
                    for (final v in org.values)
                      Chip(
                        avatar: Icon(Icons.check_circle_outline, size: 18, color: theme.colorScheme.primary),
                        label: Text(v.label),
                      ),
                  ],
                ),
              ],
              SourceFooter(url: org.sourceUrl),
              const Divider(),
              SectionHeader(l10n.eduAnchorsTitle),
              Text(edu.tagline, style: theme.textTheme.titleMedium),
              const SizedBox(height: Gap.md),
              Text(edu.mission, style: theme.textTheme.bodyLarge),
              const SizedBox(height: Gap.md),
              Text(edu.vision, style: theme.textTheme.bodyLarge),
              SourceFooter(url: edu.sourceUrl),
            ],
          );
        },
      ),
    );
  }
}
