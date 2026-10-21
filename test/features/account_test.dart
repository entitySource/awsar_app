import 'package:awsar_app/app/app.dart';
import 'package:awsar_app/core/auth/auth_repository.dart';
import 'package:awsar_app/features/opportunities/application/opportunity_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_auth.dart';
import '../helpers/fakes.dart';

Finder _field(String label) => find.widgetWithText(TextFormField, label);

Future<void> _submit(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('account-submit')));
  await settle(tester);
}

void main() {
  testWidgets('without Supabase keys the account screen explains sign-in is off', (tester) async {
    await pumpApp(tester, initialLocation: '/more/account');
    expect(find.text("Sign-in isn't set up in this build"), findsOneWidget);
    expect(find.byKey(const Key('account-submit')), findsNothing);
  });

  testWidgets('More shows a sign-in entry that opens the account screen', (tester) async {
    await pumpApp(tester, initialLocation: '/more', auth: FakeAuth());
    expect(find.text('Sign in or create an account'), findsOneWidget);
    await tester.tap(find.byKey(const Key('more-account')));
    await settle(tester);
    expect(find.byKey(const Key('account-mode')), findsOneWidget);
  });

  testWidgets('signing in shows the account, and signing out returns to the form', (tester) async {
    await pumpApp(tester, initialLocation: '/more/account', auth: FakeAuth());
    await tester.enterText(_field('Email *'), 'asha@example.com');
    await tester.enterText(_field('Password *'), 'correct-horse');
    await _submit(tester);

    expect(find.text('Signed in as asha@example.com'), findsOneWidget);
    expect(find.text('Asha Verma'), findsOneWidget);

    await tester.tap(find.byKey(const Key('account-signout')));
    await settle(tester);
    expect(find.byKey(const Key('account-submit')), findsOneWidget);
    expect(find.text('Signed out'), findsOneWidget);
  });

  testWidgets('a wrong password shows a clear error and stays signed out', (tester) async {
    final auth = FakeAuth(signInResult: const AuthFailed(AuthFailure.invalidCredentials));
    await pumpApp(tester, initialLocation: '/more/account', auth: auth);
    await tester.enterText(_field('Email *'), 'asha@example.com');
    await tester.enterText(_field('Password *'), 'wrong-password');
    await _submit(tester);

    expect(find.text('Email or password is wrong'), findsOneWidget);
    expect(find.textContaining('Signed in as'), findsNothing);
  });

  testWidgets('creating an account checks the password, then asks to confirm by email', (tester) async {
    await pumpApp(tester, initialLocation: '/more/account', auth: FakeAuth());
    await tester.tap(find.text('Create account'));
    await settle(tester);

    await tester.enterText(_field('Full name *'), 'Asha Verma');
    await tester.enterText(_field('Mobile number *'), '9876543210');
    await tester.enterText(_field('Email *'), 'asha@example.com');
    await tester.enterText(_field('Password *'), 'short');
    await _submit(tester);
    expect(find.text('Use at least 8 characters'), findsOneWidget);

    await tester.enterText(_field('Password *'), 'long-enough-1');
    await _submit(tester);
    expect(find.byKey(const Key('account-check-email')), findsOneWidget);
  });

  testWidgets('signed in, the donate form starts filled in from the account', (tester) async {
    await pumpApp(
      tester,
      initialLocation: '/get-involved/donate-india',
      auth: FakeAuth(signedIn: FakeAuth.asha),
    );
    expect(find.byKey(const Key('prefilled-note')), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Asha Verma'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'asha@example.com'), findsOneWidget);
  });

  testWidgets('signed out, the donate form starts empty', (tester) async {
    await pumpApp(tester, initialLocation: '/get-involved/donate-india', auth: FakeAuth());
    expect(find.byKey(const Key('prefilled-note')), findsNothing);
  });

  testWidgets('signing in merges saved opportunities from the phone and the account', (tester) async {
    final auth = FakeAuth(signedIn: FakeAuth.asha, cloud: {'sample-mentorship'});
    final (prefs, _) = await pumpApp(
      tester,
      initialLocation: '/opportunities',
      auth: auth,
      prefs: {
        'saved_opportunities': ['sample-scholarship'],
      },
    );
    final container = ProviderScope.containerOf(tester.element(find.byType(AwsarApp)));

    expect(container.read(savedOpportunitiesProvider), {'sample-scholarship', 'sample-mentorship'});
    expect(auth.cloud, {'sample-scholarship', 'sample-mentorship'});
    expect(prefs.getStringList('saved_opportunities')!.toSet(), {'sample-scholarship', 'sample-mentorship'});

    await container.read(savedOpportunitiesProvider.notifier).toggle('sample-scholarship');
    expect(auth.cloud, {'sample-mentorship'});
  });
}
