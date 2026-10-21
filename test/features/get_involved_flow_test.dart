import 'package:awsar_app/features/get_involved/presentation/donate_pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fakes.dart';

void main() {
  testWidgets('volunteer submit stays disabled until the commitment is ticked', (tester) async {
    final (_, launcher) = await pumpApp(tester, initialLocation: '/get-involved/volunteer');
    ButtonStyleButton submit() => tester.widget<ButtonStyleButton>(find.byKey(const Key('volunteer-submit')));
    expect(submit().onPressed, isNull);
    expect(find.text('Tick the commitment above to send your application'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextFormField, 'Full name *'), 'Asha Verma');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email *'), 'asha@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mobile number *'), '9876543210');
    await tester.ensureVisible(find.byKey(const Key('volunteer-commit')));
    await tester.tap(find.byKey(const Key('volunteer-commit')));
    await tester.pumpAndSettle();
    expect(submit().onPressed, isNotNull);

    await tester.tap(find.byKey(const Key('volunteer-submit')));
    await tester.pumpAndSettle();
    expect(launcher.opened.single.scheme, 'mailto');
    expect(find.text('Your email is ready'), findsOneWidget);
  });

  testWidgets('donate form blocks bad input, then shows a demo UPI QR', (tester) async {
    final (_, launcher) = await pumpApp(tester, initialLocation: '/get-involved/donate-india');
    await tester.tap(find.byKey(const Key('donate-continue')));
    await tester.pumpAndSettle();
    expect(find.text('This field is required'), findsWidgets);
    expect(launcher.opened, isEmpty);

    await tester.enterText(find.widgetWithText(TextFormField, 'Full name *'), 'Asha Verma');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email *'), 'asha@example.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mobile number *'), '9876543210');
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount in rupees *'), '500');
    await tester.tap(find.byKey(const Key('donate-continue')));
    await tester.pumpAndSettle();
    expect(find.text('Send your details to AWSAR'), findsNothing);
    expect(find.byKey(const Key('donate-pay-qr')), findsOneWidget);
    expect(find.byKey(const Key('donate-pay-demo')), findsOneWidget);
    expect(find.text('₹500 to AWSAR India'), findsOneWidget);

    await tester.tap(find.byKey(const Key('donate-pay-upi')));
    await tester.pumpAndSettle();
    expect(
      launcher.opened.single.toString(),
      'upi://pay?pa=awsarindia.demo%40upi&pn=AWSAR%20India&am=500.00&cu=INR&tn=Donation%20to%20AWSAR%20India',
    );

    await tester.scrollUntilVisible(
      find.byKey(const Key('donate-pay-receipt')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.byKey(const Key('donate-pay-receipt')));
    await tester.pumpAndSettle();
    expect(launcher.opened.last.toString(), startsWith('mailto:support@awsarindia.org'));
    expect(find.text('Your email is ready'), findsOneWidget);
  });

  test('UPI amounts are normalised for UPI apps', () {
    expect(DonatePayScreen.upiAmount('1,500'), '1500.00');
    expect(DonatePayScreen.upiAmount(' 250.5 '), '250.50');
  });

  testWidgets('a failed link shows a snackbar instead of failing silently', (tester) async {
    await pumpApp(tester, initialLocation: '/more/contact', launcher: FakeLinkLauncher(result: false));
    await tester.tap(find.text('+91 98916 25350'));
    await tester.pumpAndSettle();
    expect(find.text("Couldn't open the link. Check your connection and try again."), findsOneWidget);
  });
}
