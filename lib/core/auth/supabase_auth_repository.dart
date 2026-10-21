import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_repository.dart';

/// Supabase email + password accounts. Only the publishable key is used;
/// row level security keeps each user to their own saved rows.
class SupabaseAuthRepository implements AuthRepository, SavedOpportunitiesRemote {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;
  static const _table = 'saved_opportunities';

  @override
  bool get isConfigured => true;

  @override
  AppUser? get currentUser => _toAppUser(_client.auth.currentUser);

  @override
  Stream<AppUser?> userChanges() => _client.auth.onAuthStateChange.map((s) => _toAppUser(s.session?.user));

  @override
  Future<AuthResult> signIn({required String email, required String password}) async {
    try {
      final res = await _client.auth.signInWithPassword(email: email.trim(), password: password);
      final user = _toAppUser(res.user);
      return user == null ? const AuthFailed(AuthFailure.unknown) : AuthSignedIn(user);
    } on AuthException catch (e) {
      return AuthFailed(_failure(e));
    } catch (_) {
      return const AuthFailed(AuthFailure.network);
    }
  }

  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final res = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'full_name': fullName.trim(), 'phone': phone.trim()},
      );
      final user = _toAppUser(res.user);
      if (res.session == null || user == null) return const AuthNeedsConfirmation();
      return AuthSignedIn(user);
    } on AuthException catch (e) {
      return AuthFailed(_failure(e));
    } catch (_) {
      return const AuthFailed(AuthFailure.network);
    }
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  Future<Set<String>> fetch() async {
    final rows = await _client.from(_table).select('opportunity_id');
    return {for (final r in rows) r['opportunity_id'] as String};
  }

  @override
  Future<void> addAll(Iterable<String> ids) async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null || ids.isEmpty) return;
    await _client.from(_table).upsert([
      for (final id in ids) {'user_id': uid, 'opportunity_id': id},
    ], ignoreDuplicates: true);
  }

  @override
  Future<void> remove(String id) async {
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return;
    await _client.from(_table).delete().eq('user_id', uid).eq('opportunity_id', id);
  }

  static AppUser? _toAppUser(User? u) {
    if (u == null) return null;
    final meta = u.userMetadata ?? const {};
    return AppUser(
      id: u.id,
      email: u.email ?? '',
      fullName: meta['full_name'] as String?,
      phone: meta['phone'] as String?,
    );
  }

  static AuthFailure _failure(AuthException e) => switch (e.code) {
    'invalid_credentials' => AuthFailure.invalidCredentials,
    'user_already_exists' || 'email_exists' => AuthFailure.emailInUse,
    'weak_password' => AuthFailure.weakPassword,
    'email_not_confirmed' => AuthFailure.emailNotConfirmed,
    _ => e is AuthRetryableFetchException ? AuthFailure.network : AuthFailure.unknown,
  };
}
