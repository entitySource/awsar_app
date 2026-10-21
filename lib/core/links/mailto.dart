/// Builds a `mailto:` URI. Encodes with `%20` rather than `+`, because many
/// Android mail apps show `+` literally.
Uri mailtoUri({required String to, required String subject, required String body}) {
  String enc(String s) => Uri.encodeComponent(s);
  return Uri.parse('mailto:$to?subject=${enc(subject)}&body=${enc(body)}');
}

Uri telUri(String phone) => Uri(scheme: 'tel', path: phone.replaceAll(RegExp(r'[^0-9+]'), ''));
