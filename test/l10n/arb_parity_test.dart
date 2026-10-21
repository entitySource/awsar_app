import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, dynamic> arb(String locale) =>
      jsonDecode(File('lib/l10n/app_$locale.arb').readAsStringSync()) as Map<String, dynamic>;

  test('app_hi.arb has exactly the keys of app_en.arb', () {
    Set<String> keys(Map<String, dynamic> m) => m.keys.where((k) => !k.startsWith('@')).toSet();
    final en = arb('en');
    final hi = arb('hi');
    expect(keys(hi).difference(keys(en)), isEmpty, reason: 'extra keys in hi');
    expect(keys(en).difference(keys(hi)), isEmpty, reason: 'missing keys in hi');
  });

  test('every placeholder survives translation', () {
    final en = arb('en');
    final hi = arb('hi');
    final ph = RegExp(r'\{(\w+)\}');
    for (final key in en.keys.where((k) => !k.startsWith('@'))) {
      final want = ph.allMatches(en[key] as String).map((m) => m[1]).toSet();
      final got = ph.allMatches(hi[key] as String).map((m) => m[1]).toSet();
      expect(got, want, reason: key);
    }
  });
}
