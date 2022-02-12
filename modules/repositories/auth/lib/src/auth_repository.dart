import 'package:auth/src/entities/auth_providers.dart';

import 'entities/auth_result.dart';
import 'providers/google_auth_service.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  const factory AuthRepository({
    required GoogleAuthService googleAuthService,
  }) = _AuthRepositoryImpl;

  factory AuthRepository.create() = _AuthRepositoryImpl.create;

  Stream<AuthResult?> currentSessionChanges([
    AuthProviders provider = AuthProviders.google,
  ]);

  Future<AuthResult?> getCurrentSession([
    AuthProviders provider = AuthProviders.google,
  ]);

  Future<AuthResult?> signIn([
    AuthProviders provider = AuthProviders.google,
  ]);

  Future<AuthResult> signUp({
    AuthProviders provider = AuthProviders.google,
    required String email,
    required String password,
  });

  Future<void> signOut([
    AuthProviders provider = AuthProviders.google,
  ]);
}
