import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/content/content_providers.dart';
import '../../../core/content/models/media_item.dart';
import '../../../core/links/open_link.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/page_scaffold.dart';
import '../../../core/widgets/source_footer.dart';
import '../../../l10n/app_localizations.dart';

class MediaScreen extends ConsumerWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PageScaffold(
      title: l10n.mediaTitle,
      body: AsyncValueView(
        value: ref.watch(contentProvider),
        onRetry: () => ref.invalidate(contentProvider),
        data: (c) {
          if (c.media.isEmpty) {
            return ListView(
              children: [
                EmptyState(
                  icon: Icons.photo_library_outlined,
                  title: l10n.mediaEmpty,
                  body: l10n.mediaEmptyBody,
                  actionLabel: l10n.mediaOpenWebsite,
                  onAction: () => openLink(context, ref, Uri.parse(c.org.sourceUrl)),
                ),
              ],
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: Gap.lg),
            children: [
              for (final m in c.media) ...[
                Card(
                  child: ListTile(
                    leading: m.imageAsset == null
                        ? Icon(_icon(m.kind))
                        : Image.asset(
                            m.imageAsset!,
                            width: 56,
                            fit: BoxFit.cover,
                            semanticLabel: m.alt,
                            excludeFromSemantics: m.alt == null,
                          ),
                    title: Text(m.title),
                    subtitle: m.caption == null ? null : Text(m.caption!),
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () => openLink(context, ref, Uri.parse(m.url)),
                  ),
                ),
                const SizedBox(height: Gap.sm),
              ],
              SourceFooter(url: c.org.sourceUrl),
            ],
          );
        },
      ),
    );
  }

  static IconData _icon(MediaKind k) => switch (k) {
    MediaKind.photo => Icons.photo_outlined,
    MediaKind.video => Icons.play_circle_outline,
    MediaKind.report => Icons.picture_as_pdf_outlined,
  };
}
