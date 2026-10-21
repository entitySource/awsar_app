import '../json_read.dart';

enum MediaKind { photo, video, report }

/// Photos, videos and annual reports. Filled by `scripts/build-content.mjs`
/// from the scrape; empty in the seed content.
class MediaItem {
  const MediaItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.url,
    required this.sourceUrl,
    this.caption,
    this.imageAsset,
    this.alt,
  });

  final String id;
  final MediaKind kind;
  final String title;
  final String? caption;

  /// Bundled image (photo or video thumbnail), if any.
  final String? imageAsset;
  final String? alt;

  /// Video or PDF URL, opened outside the app.
  final String url;
  final String sourceUrl;

  factory MediaItem.fromJson(Json j, String path) {
    final kindName = reqStr(j, 'kind', path);
    final kind = MediaKind.values.where((k) => k.name == kindName).firstOrNull;
    if (kind == null) throw FormatException('$path.kind "$kindName" unknown');
    return MediaItem(
      id: reqStr(j, 'id', path),
      kind: kind,
      title: reqStr(j, 'title', path),
      caption: optStr(j, 'caption'),
      imageAsset: optStr(j, 'imageAsset'),
      alt: optStr(j, 'alt'),
      url: reqStr(j, 'url', path),
      sourceUrl: reqStr(j, 'sourceUrl', path),
    );
  }
}
