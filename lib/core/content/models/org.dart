import '../json_read.dart';
import 'labeled_value.dart';

class Org {
  const Org({
    required this.name,
    required this.tagline,
    required this.intro,
    required this.storyLead,
    required this.story,
    required this.vision,
    required this.mission,
    required this.values,
    required this.impact,
    required this.sourceUrl,
  });

  final String name;
  final String tagline;
  final String intro;
  final String? storyLead;
  final List<String> story;
  final String vision;
  final String mission;
  final List<LabeledValue> values;
  final List<LabeledValue> impact;
  final String sourceUrl;

  factory Org.fromJson(Json j, String path) => Org(
    name: reqStr(j, 'name', path),
    tagline: reqStr(j, 'tagline', path),
    intro: reqStr(j, 'intro', path),
    storyLead: optStr(j, 'storyLead'),
    story: strList(j, 'story'),
    vision: reqStr(j, 'vision', path),
    mission: reqStr(j, 'mission', path),
    values: LabeledValue.listOf(j, 'values', path),
    impact: LabeledValue.listOf(j, 'impact', path),
    sourceUrl: reqStr(j, 'sourceUrl', path),
  );
}

class EduAnchorsInfo {
  const EduAnchorsInfo({
    required this.tagline,
    required this.mission,
    required this.vision,
    required this.typeTaglines,
    required this.sourceUrl,
  });

  final String tagline;
  final String mission;
  final String vision;
  final Map<String, String> typeTaglines;
  final String sourceUrl;

  factory EduAnchorsInfo.fromJson(Json j, String path) => EduAnchorsInfo(
    tagline: reqStr(j, 'tagline', path),
    mission: reqStr(j, 'mission', path),
    vision: reqStr(j, 'vision', path),
    typeTaglines: (j['typeTaglines'] as Map<String, dynamic>? ?? const {}).map((k, v) => MapEntry(k, v as String)),
    sourceUrl: reqStr(j, 'sourceUrl', path),
  );
}
