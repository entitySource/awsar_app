import 'package:awsar_app/core/content/content_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  final repo = ContentRepository(read: readAssetFromDisk);

  test('English content parses strictly: 9 programmes, nothing skipped', () async {
    final c = await repo.load('en');
    expect(c.programmes, hasLength(9));
    expect(c.meta.skippedItems, isEmpty);
    expect(c.meta.fellBackToEnglish, isEmpty);
    expect(c.meta.draft, isFalse);
    expect(c.programmes.map((p) => p.order), orderedEquals(List.generate(9, (i) => i + 1)));
    for (final o in c.opportunities) {
      expect(o.sourceUrl, startsWith('https://'));
    }
  });

  test('Hindi content parses, is marked draft, and keeps the same ids', () async {
    final en = await repo.load('en');
    final hi = await repo.load('hi');
    expect(hi.meta.skippedItems, isEmpty);
    expect(hi.meta.fellBackToEnglish, isEmpty);
    expect(hi.meta.draft, isTrue);
    expect(hi.programmes.map((p) => p.id), en.programmes.map((p) => p.id));
    expect(hi.opportunities.map((o) => o.id), en.opportunities.map((o) => o.id));
    // Verbatim fields must not be translated.
    expect(hi.contact.phones, en.contact.phones);
    expect(hi.donate.handoffEmail, en.donate.handoffEmail);
    expect(hi.org.impact.map((s) => s.value), en.org.impact.map((s) => s.value));
  });

  test('a missing Hindi file falls back to English for that file only', () async {
    final partial = ContentRepository(
      read: (path) {
        if (path == 'assets/content/hi/media.json') throw Exception('missing');
        return readAssetFromDisk(path);
      },
    );
    final hi = await partial.load('hi');
    expect(hi.meta.fellBackToEnglish, ['media']);
    expect(hi.programmes, hasLength(9));
  });

  test('one broken listing is skipped, not fatal', () async {
    final broken = ContentRepository(
      read: (path) async {
        final raw = await readAssetFromDisk(path);
        if (path.endsWith('en/opportunities.json')) {
          return raw.replaceFirst('"type": "mentorship"', '"type": "unknown-type"');
        }
        return raw;
      },
    );
    final c = await broken.load('en');
    expect(c.opportunities, hasLength(2));
    expect(c.meta.skippedItems, ['opportunities.items[1]']);
  });
}
