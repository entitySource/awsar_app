import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repository.dart';

/// Supabase project settings, passed at build time:
/// `flutter run --dart-define=SUPABASE_URL=… --dart-define=SUPABASE_PUBLISHABLE_KEY=…`
/// Use the publishable (or legacy anon) key, never the secret/service_role key.
const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabasePublishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
bool get supabaseConfigured => supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;

/// Overridden in `main.dart` with Supabase when it is configured.
final authRepositoryProvider = Provider<AuthRepository>((ref) => const DisabledAuthRepository());

final savedRemoteProvider = Provider<SavedOpportunitiesRemote>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  return auth is SavedOpportunitiesRemote ? auth as SavedOpportunitiesRemote : const DisabledAuthRepository();
});

/// The signed-in user, or null. Follows sign-in, sign-out and session expiry.
class AuthController extends Notifier<AppUser?> {
  @override
  AppUser? build() {
    final repo = ref.watch(authRepositoryProvider);
    final sub = repo.userChanges().listen((u) => state = u);
    ref.onDispose(sub.cancel);
    return repo.currentUser;
  }

  Future<AuthResult> signIn(String email, String password) async {
    final r = await ref.read(authRepositoryProvider).signIn(email: email, password: password);
    if (r is AuthSignedIn) state = r.user;
    return r;
  }

  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    final r = await ref
        .read(authRepositoryProvider)
        .signUp(email: email, password: password, fullName: fullName, phone: phone);
    if (r is AuthSignedIn) state = r.user;
    return r;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = null;
  }
}

final authControllerProvider = NotifierProvider<AuthController, AppUser?>(AuthController.new);
