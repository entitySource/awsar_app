/// Who is signed in. Name and mobile come from the details given at sign-up
/// and are used to fill in the Donate and Volunteer forms.
class AppUser {
  const AppUser({required this.id, required this.email, this.fullName, this.phone});

  final String id;
  final String email;
  final String? fullName;
  final String? phone;
}

/// Why a sign-in or sign-up did not work; screens turn it into localized text.
enum AuthFailure { invalidCredentials, emailInUse, weakPassword, emailNotConfirmed, network, notConfigured, unknown }

/// The outcome of [AuthRepository.signIn] or [AuthRepository.signUp].
sealed class AuthResult {
  const AuthResult();
}

class AuthSignedIn extends AuthResult {
  const AuthSignedIn(this.user);
  final AppUser user;
}

/// Sign-up worked but the account must be confirmed from the email first.
class AuthNeedsConfirmation extends AuthResult {
  const AuthNeedsConfirmation();
}

class AuthFailed extends AuthResult {
  const AuthFailed(this.failure);
  final AuthFailure failure;
}

/// Accounts. Screens and providers only see this, so tests swap in a fake and
/// a build without Supabase keys still runs.
abstract class AuthRepository {
  bool get isConfigured;
  AppUser? get currentUser;
  Stream<AppUser?> userChanges();
  Future<AuthResult> signIn({required String email, required String password});
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });
  Future<void> signOut();
}

/// Saved opportunity ids for the signed-in user, kept in the cloud.
abstract class SavedOpportunitiesRemote {
  Future<Set<String>> fetch();
  Future<void> addAll(Iterable<String> ids);
  Future<void> remove(String id);
}

/// Used when the app is built without SUPABASE_URL / SUPABASE_PUBLISHABLE_KEY.
class DisabledAuthRepository implements AuthRepository, SavedOpportunitiesRemote {
  const DisabledAuthRepository();

  @override
  bool get isConfigured => false;
  @override
  AppUser? get currentUser => null;
  @override
  Stream<AppUser?> userChanges() => const Stream.empty();
  @override
  Future<AuthResult> signIn({required String email, required String password}) async =>
      const AuthFailed(AuthFailure.notConfigured);
  @override
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async => const AuthFailed(AuthFailure.notConfigured);
  @override
  Future<void> signOut() async {}
  @override
  Future<Set<String>> fetch() async => const {};
  @override
  Future<void> addAll(Iterable<String> ids) async {}
  @override
  Future<void> remove(String id) async {}
}
