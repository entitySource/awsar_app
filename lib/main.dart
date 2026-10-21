import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/auth/auth_providers.dart';
import 'core/auth/supabase_auth_repository.dart';
import 'core/storage/prefs_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // Accounts are on only when the build was given a Supabase project
  // (see README); without one the app runs fully offline.
  final overrides = [prefsProvider.overrideWithValue(prefs)];
  if (supabaseConfigured) {
    await Supabase.initialize(url: supabaseUrl, publishableKey: supabasePublishableKey);
    overrides.add(authRepositoryProvider.overrideWithValue(SupabaseAuthRepository(Supabase.instance.client)));
  }
  runApp(ProviderScope(overrides: overrides, child: const AwsarApp()));
}
