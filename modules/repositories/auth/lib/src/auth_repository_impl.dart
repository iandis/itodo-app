part of 'auth_repository.dart';

class _AuthRepositoryImpl implements AuthRepository {
  const _AuthRepositoryImpl({
    required GoogleAuthService googleAuthService,
  }) : _googleAuthService = googleAuthService;

  factory _AuthRepositoryImpl.create() {
    return _AuthRepositoryImpl(
      googleAuthService: GoogleAuthService.create(),
    );
  }

  final GoogleAuthService _googleAuthService;

  @override
  Future<AuthResult?> googleSignIn() {
    return _googleAuthService.signIn();
  }

  @override
  Future<AuthResult> googleSignUp({
    required String email,
    required String password,
  }) {
    return _googleAuthService.signUp(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> googleSignOut() {
    return _googleAuthService.signOut();
  }
}
