import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_auth.dart';
import '../helpers/fakes.dart';

const _screens = [
  '/',
  '/programmes',
  '/programmes/child-protection',
  '/opportunities',
  '/opportunities/sample-scholarship',
  '/get-involved',
  '/get-involved/donate-india',
  '/get-involved/donate-international',
  '/get-involved/volunteer',
  '/more',
  '/more/about',
  '/more/contact',
  '/more/media',
];

void main() {
  for (final path in _screens) {
    testWidgets('$path meets Android tap-target, label and contrast guidelines', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpApp(tester, initialLocation: path);
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  }

  for (final locale in ['en', 'hi']) {
    for (final path in _screens) {
      testWidgets('$path has no overflow at text scale 2.0 ($locale)', (tester) async {
        await pumpApp(tester, initialLocation: path, textScale: 2.0, prefs: {'locale': locale});
        expect(tester.takeException(), isNull);
        // The page body must actually get space (a fixed bar can't swallow it).
        expect(tester.getSize(find.byType(ListView).first).height, greaterThan(300));
      });
    }
  }

  // The account screen, signed out (form) and signed in.
  for (final signedIn in [false, true]) {
    final label = signedIn ? 'signed in' : 'signed out';
    testWidgets('/more/account ($label) meets Android guidelines', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpApp(
        tester,
        initialLocation: '/more/account',
        auth: FakeAuth(signedIn: signedIn ? FakeAuth.asha : null),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    for (final locale in ['en', 'hi']) {
      testWidgets('/more/account ($label) has no overflow at text scale 2.0 ($locale)', (tester) async {
        await pumpApp(
          tester,
          initialLocation: '/more/account',
          textScale: 2.0,
          prefs: {'locale': locale},
          auth: FakeAuth(signedIn: signedIn ? FakeAuth.asha : null),
        );
        expect(tester.takeException(), isNull);
        expect(tester.getSize(find.byType(ListView).first).height, greaterThan(300));
      });
    }
  }
}
