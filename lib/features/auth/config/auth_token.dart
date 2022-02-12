import 'package:auth/auth.dart';
import 'package:network/network.dart';

class AuthToken extends GQLAuth {
  AuthToken({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    _authRepository.currentSessionChanges().listen(_setToken);
  }

  final AuthRepository _authRepository;

  String? _token;

  void _setToken(AuthResult? currentSession) {
    _token = currentSession?.token;
  }

  @override
  String? getToken() => _token;
}
