/// Small, path-aware JSON readers so a bad content file points at the exact
/// field (`programmes[3].title missing`) instead of a generic cast error.
typedef Json = Map<String, dynamic>;

String reqStr(Json j, String key, String path) {
  final v = j[key];
  if (v is String && v.isNotEmpty) return v;
  throw FormatException('$path.$key missing or not a string');
}

String? optStr(Json j, String key) {
  final v = j[key];
  return v is String && v.isNotEmpty ? v : null;
}

int reqInt(Json j, String key, String path) {
  final v = j[key];
  if (v is int) return v;
  throw FormatException('$path.$key missing or not an int');
}

bool optBool(Json j, String key) => j[key] == true;

List<String> strList(Json j, String key) => (j[key] as List<dynamic>? ?? const []).whereType<String>().toList();

Json reqObj(Json j, String key, String path) {
  final v = j[key];
  if (v is Map<String, dynamic>) return v;
  throw FormatException('$path.$key missing or not an object');
}

/// Parses a list leniently: a bad item is skipped and reported through
/// [onSkip], so one broken listing can't blank a whole screen.
List<T> objList<T>(
  Json j,
  String key,
  String path,
  T Function(Json item, String itemPath) parse, {
  void Function(String itemPath, Object error)? onSkip,
}) {
  final raw = j[key] as List<dynamic>? ?? const [];
  final out = <T>[];
  for (var i = 0; i < raw.length; i++) {
    final itemPath = '$path.$key[$i]';
    try {
      final item = raw[i];
      if (item is! Map<String, dynamic>) {
        throw FormatException('$itemPath is not an object');
      }
      out.add(parse(item, itemPath));
    } on FormatException catch (e) {
      onSkip?.call(itemPath, e);
    }
  }
  return out;
}
