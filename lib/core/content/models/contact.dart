import '../json_read.dart';
import 'labeled_value.dart';

class Contact {
  const Contact({
    required this.offices,
    required this.phones,
    required this.emails,
    required this.helplines,
    required this.eduAnchorsPhones,
    required this.eduAnchorsEmails,
    required this.sourceUrl,
  });

  final List<LabeledValue> offices;
  final List<String> phones;
  final List<String> emails;
  final List<LabeledValue> helplines;
  final List<String> eduAnchorsPhones;
  final List<String> eduAnchorsEmails;
  final String sourceUrl;

  factory Contact.fromJson(Json j, String path) {
    final edu = j['eduAnchors'] as Map<String, dynamic>? ?? const {};
    return Contact(
      offices: LabeledValue.listOf(j, 'offices', path),
      phones: strList(j, 'phones'),
      emails: strList(j, 'emails'),
      helplines: LabeledValue.listOf(j, 'helplines', path),
      eduAnchorsPhones: strList(edu, 'phones'),
      eduAnchorsEmails: strList(edu, 'emails'),
      sourceUrl: reqStr(j, 'sourceUrl', path),
    );
  }
}
