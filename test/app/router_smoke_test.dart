import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  testWidgets('all five tabs open and show their content', (tester) async {
    await pumpApp(tester);
    expect(find.text('Creating Opportunities for Development'), findsOneWidget);

    await tester.tap(find.text('Our work').last);
    await tester.pumpAndSettle();
    expect(find.text('Research & Analysis'), findsOneWidget);

    await tester.tap(find.text('Students'));
    await tester.pumpAndSettle();
    expect(find.text('Empowering Future, Connecting Opportunities'), findsOneWidget);

    await tester.tap(find.text('Get involved').last);
    await tester.pumpAndSettle();
    expect(find.text('Donate from India'), findsOneWidget);

    await tester.tap(find.text('More').last);
    await tester.pumpAndSettle();
    expect(find.text('About AWSAR'), findsOneWidget);
  });

  testWidgets('programme card opens its detail page', (tester) async {
    await pumpApp(tester, initialLocation: '/programmes');
    await tester.tap(find.text('Child Protection & Safety'));
    await tester.pumpAndSettle();
    expect(find.text('Support this work'), findsOneWidget);
    expect(find.text('20,000+'), findsOneWidget);
    expect(find.textContaining('Every child deserves a safe, nurturing, protective environment.'), findsOneWidget);
  });

  test('every programme has a description in English and Hindi', () {
    for (final locale in ['en', 'hi']) {
      final json = jsonDecode(File('assets/content/$locale/programmes.json').readAsStringSync()) as Map<String, dynamic>;
      final items = json['items'] as List<dynamic>;
      expect(items, hasLength(9));
      for (final item in items.cast<Map<String, dynamic>>()) {
        expect(item['body'] as List<dynamic>, isNotEmpty, reason: '$locale ${item['id']}');
      }
    }
  });

  testWidgets('unknown programme id shows an empty state, not a crash', (tester) async {
    await pumpApp(tester, initialLocation: '/programmes/nope');
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}
