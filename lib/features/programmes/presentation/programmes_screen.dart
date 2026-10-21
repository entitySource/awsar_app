import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/draft_badge.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/programme_card.dart';

class ProgrammesScreen extends ConsumerWidget {
  const ProgrammesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PageScaffold(
      title: l10n.programmesTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
          children: [
            const SizedBox(height: Gap.sm),
            Text(
              l10n.programmesSubtitle(c.programmes.length),
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            if (c.meta.draft) const DraftBadge(),
            const SizedBox(height: Gap.md),
            for (final p in c.programmes) ...[ProgrammeCard(programme: p), const SizedBox(height: Gap.md)],
            SourceFooter(url: c.org.sourceUrl),
          ],
        ),
      ),
    );
  }
}
