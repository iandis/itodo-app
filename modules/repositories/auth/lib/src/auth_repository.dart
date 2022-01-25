import 'entities/auth_result.dart';
import 'providers/google_auth_service.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  const factory AuthRepository({
    required GoogleAuthService googleAuthService,
  }) = _AuthRepositoryImpl;

  factory AuthRepository.create() = _AuthRepositoryImpl.create;

  Future<AuthResult?> googleSignIn();

  Future<AuthResult> googleSignUp({
    required String email,
    required String password,
  });

  Future<void> googleSignOut();
}
