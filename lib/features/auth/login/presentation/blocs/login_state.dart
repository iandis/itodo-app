part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => <Object?>[];
}

class LoginInit extends LoginState {
  const LoginInit();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  const LoginLoaded(this.user);

  final User user;

  @override
  List<Object?> get props => <Object?>[user];
}

class LoginError extends LoginState {
  const LoginError(this.error);

  final String error;

  @override
  List<Object?> get props => <Object?>[error];
}
