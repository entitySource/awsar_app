import 'dart:async';

import 'package:awsar_app/core/auth/auth_repository.dart';

/// In-memory accounts and cloud saved list, for widget tests.
class FakeAuth implements AuthRepository, SavedOpportunitiesRemote {
  FakeAuth({this.signInResult, this.signUpResult, AppUser? signedIn, Set<String>? cloud})
    : _user = signedIn,
      cloud = cloud ?? {};

  AuthResult? signInResult;
  AuthResult? signUpResult;
  final Set<String> cloud;
  AppUser? _user;
  final _changes = StreamController<AppUser?>.broadcast();

  static const asha = AppUser(id: 'u1', email: 'asha@example.com', fullName: 'Asha Verma', phone: '9876543210');

  @override
  bool get isConfigured => true;
  @override
  AppUser? get currentUser => _user;
  @override
  Stream<AppUser?> userChanges() => _changes.stream;

  @override
  Future<AuthResult> signIn({required String email, required String password}) async {
    final r = signInResult ?? const AuthSignedIn(asha);
    if (r is AuthSignedIn) _user = r.user;
    return r;
  }

  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async => signUpResult ?? const AuthNeedsConfirmation();

  @override
  Future<void> signOut() async => _user = null;

  @override
  Future<Set<String>> fetch() async => {...cloud};
  @override
  Future<void> addAll(Iterable<String> ids) async => cloud.addAll(ids);
  @override
  Future<void> remove(String id) async => cloud.remove(id);
}
