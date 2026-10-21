import '../json_read.dart';

/// A label/value pair, e.g. an impact stat ("12,000+", "Children enrolled")
/// or an office address. Values are kept exactly as written on the source site.
class LabeledValue {
  const LabeledValue({required this.label, required this.value});

  final String label;
  final String value;

  factory LabeledValue.fromJson(Json j, String path) =>
      LabeledValue(label: reqStr(j, 'label', path), value: (j['value'] as String?) ?? '');

  static List<LabeledValue> listOf(Json j, String key, String path) => objList(j, key, path, LabeledValue.fromJson);
}
