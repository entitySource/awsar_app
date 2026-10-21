import '../json_read.dart';

enum OpportunityType { scholarship, mentorship, internship }

class Opportunity {
  const Opportunity({
    required this.id,
    required this.type,
    required this.title,
    required this.summary,
    required this.sample,
    required this.sourceUrl,
    this.provider,
    this.eligibility,
    this.amount,
    this.deadline,
    this.location,
    this.mode,
    this.applyUrl,
    this.tags = const [],
  });

  final String id;
  final OpportunityType type;
  final String title;
  final String? provider;
  final String summary;
  final String? eligibility;

  /// As written on the source site; never re-formatted or invented.
  final String? amount;
  final DateTime? deadline;
  final String? location;
  final String? mode;
  final String? applyUrl;
  final List<String> tags;

  /// True for illustrative listings; the UI must label these "Sample".
  final bool sample;
  final String sourceUrl;

  factory Opportunity.fromJson(Json j, String path) {
    final typeName = reqStr(j, 'type', path);
    final type = OpportunityType.values.where((t) => t.name == typeName).firstOrNull;
    if (type == null) throw FormatException('$path.type "$typeName" unknown');
    final deadline = optStr(j, 'deadline');
    return Opportunity(
      id: reqStr(j, 'id', path),
      type: type,
      title: reqStr(j, 'title', path),
      provider: optStr(j, 'provider'),
      summary: reqStr(j, 'summary', path),
      eligibility: optStr(j, 'eligibility'),
      amount: optStr(j, 'amount'),
      deadline: deadline == null ? null : DateTime.tryParse(deadline),
      location: optStr(j, 'location'),
      mode: optStr(j, 'mode'),
      applyUrl: optStr(j, 'applyUrl'),
      tags: strList(j, 'tags'),
      sample: optBool(j, 'sample'),
      sourceUrl: reqStr(j, 'sourceUrl', path),
    );
  }
}
