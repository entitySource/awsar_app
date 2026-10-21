import 'dart:io';

import 'package:awsar_app/app/app.dart';
import 'package:awsar_app/app/router.dart';
import 'package:awsar_app/core/auth/auth_providers.dart';
import 'package:awsar_app/core/auth/auth_repository.dart';
import 'package:awsar_app/core/content/content_providers.dart';
import 'package:awsar_app/core/content/content_repository.dart';
import 'package:awsar_app/core/links/link_launcher.dart';
import 'package:awsar_app/core/storage/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records launches instead of opening anything.
class FakeLinkLauncher implements LinkLauncher {
  FakeLinkLauncher({this.result = true});

  final bool result;
  final opened = <Uri>[];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return result;
  }
}

/// Reads content JSON straight from disk (for pure Dart tests).
Future<String> readAssetFromDisk(String path) => File(path).readAsString();

/// Pumps the whole app on a phone-sized screen.
Future<(SharedPreferences, FakeLinkLauncher)> pumpApp(
  WidgetTester tester, {
  String initialLocation = '/',
  Map<String, Object> prefs = const {},
  double textScale = 1.0,
  FakeLinkLauncher? launcher,
  AuthRepository? auth,
}) async {
  tester.view.physicalSize = const Size(412 * 3, 915 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  final fake = launcher ?? FakeLinkLauncher();
  // Load content from disk up front so screens render on the first frames.
  final repo = ContentRepository(read: readAssetFromDisk);
  await tester.runAsync(() => Future.wait([repo.load('en'), repo.load('hi')]));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        prefsProvider.overrideWithValue(sp),
        linkLauncherProvider.overrideWithValue(fake),
        contentRepositoryProvider.overrideWithValue(repo),
        routerProvider.overrideWithValue(buildRouter(initialLocation: initialLocation)),
        if (auth != null) authRepositoryProvider.overrideWithValue(auth),
      ],
      child: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: const AwsarApp(),
      ),
    ),
  );
  await settle(tester);
  return (sp, fake);
}

/// Content futures were created in a real-async zone, so let real
/// microtasks run before settling the fake clock.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 3; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pumpAndSettle();
  }
}
