import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  testWidgets('EN | हिं switches every string instantly and is remembered', (tester) async {
    final (prefs, _) = await pumpApp(tester);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('हिं'));
    await settle(tester);

    expect(find.text('होम'), findsOneWidget);
    expect(find.text('दान करें'), findsOneWidget);
    expect(find.text('ड्राफ़्ट अनुवाद'), findsWidgets);
    expect(prefs.getString('locale'), 'hi');
  });

  testWidgets('starts in Hindi when that was saved', (tester) async {
    await pumpApp(tester, prefs: {'locale': 'hi'});
    expect(find.text('होम'), findsOneWidget);
    expect(find.byType(SegmentedButton<String>), findsOneWidget);
  });
}
