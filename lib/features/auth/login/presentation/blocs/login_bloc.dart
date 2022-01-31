import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purifier/purifier.dart';
import 'package:user/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const LoginInit()) {
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> _onLoginWithGoogle(
    LoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    if (state is LoginLoading) {
      return;
    }

    emit(const LoginLoading());

    final result = await Purifier().async(() => _loginWithGoogle(emit));

    if (result.hasError) {
      emit(LoginError(result.error));
    }
  }

  Future<void> _loginWithGoogle(Emitter<LoginState> emit) async {
    final AuthResult? authResult = await _authRepository.signIn();

    if (authResult == null) {
      return emit(const LoginInit());
    }

    final User user = User(
      name: authResult.name,
      email: authResult.email,
      image: authResult.image,
    );

    if (authResult.isNewUser) {
      final UserCreateInput createInput = UserCreateInput(user);
      final User newUser = await _userRepository.create(createInput);
      return emit(LoginLoaded(newUser));
    }

    emit(LoginLoaded(user));
  }
}
