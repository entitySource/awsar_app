import '../json_read.dart';
import 'labeled_value.dart';

class Programme {
  const Programme({
    required this.id,
    required this.order,
    required this.title,
    required this.summary,
    required this.icon,
    required this.body,
    required this.impact,
    required this.sourceUrl,
  });

  final String id;
  final int order;
  final String title;
  final String summary;

  /// Material Symbols name (see `programmeIcon`), kept verbatim across locales.
  final String icon;
  final List<String> body;
  final List<LabeledValue> impact;
  final String sourceUrl;

  factory Programme.fromJson(Json j, String path) => Programme(
    id: reqStr(j, 'id', path),
    order: reqInt(j, 'order', path),
    title: reqStr(j, 'title', path),
    summary: reqStr(j, 'summary', path),
    icon: optStr(j, 'icon') ?? 'volunteer_activism',
    body: strList(j, 'body'),
    impact: LabeledValue.listOf(j, 'impact', path),
    sourceUrl: reqStr(j, 'sourceUrl', path),
  );
}
