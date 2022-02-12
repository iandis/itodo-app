import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/components/app_loading_indicator.dart';
import '/shared/theme/app_colors.dart';
import '../blocs/login_bloc.dart';

part 'login_view.props.dart';
part '../components/login_success_container.dart';

class LoginViewArgs {
  const LoginViewArgs({this.onLoggedIn});

  final void Function(BuildContext context)? onLoggedIn;
}

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
    required this.args,
  }) : super(key: key);

  final LoginViewArgs args;
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends _LoginViewProps {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state is LoginError) {
            _onError(state.error);
          } else if (state is LoginLoaded) {
            _onLoggedIn(state.user.email);
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state is LoginLoaded) {
            final String? username = state.user.name;
            return _LoginSuccessContainer(username: username);
          }

          if (state is! LoginError) {
            return const AppLoadingIndicator(size: 16);
          }

          return Center(
            child: OutlinedButton(
              onPressed: _loginWithGoogle,
              child: const Text('Sign in with Google'),
            ),
          );
        },
      ),
    );
  }
}
