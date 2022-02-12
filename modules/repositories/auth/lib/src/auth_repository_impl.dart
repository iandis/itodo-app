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
  Stream<AuthResult?> currentSessionChanges([
    AuthProviders provider = AuthProviders.google,
  ]) {
    switch (provider) {
      case AuthProviders.google:
        return _googleAuthService.currentSession;
    }
  }

  @override
  Future<AuthResult?> getCurrentSession([
    AuthProviders provider = AuthProviders.google,
  ]) {
    switch (provider) {
      case AuthProviders.google:
        return _googleAuthService.getCurrentSession();
    }
  }

  @override
  Future<AuthResult?> signIn([
    AuthProviders provider = AuthProviders.google,
  ]) {
    switch (provider) {
      case AuthProviders.google:
        return _googleAuthService.signIn();
    }
  }

  @override
  Future<AuthResult> signUp({
    AuthProviders provider = AuthProviders.google,
    required String email,
    required String password,
  }) {
    switch (provider) {
      case AuthProviders.google:
        return _googleAuthService.signUp(
          email: email,
          password: password,
        );
    }
  }

  @override
  Future<void> signOut([
    AuthProviders provider = AuthProviders.google,
  ]) {
    switch (provider) {
      case AuthProviders.google:
        return _googleAuthService.signOut();
    }
  }
}
