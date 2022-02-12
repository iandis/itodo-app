import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:view_router/view_router.dart';

import '../blocs/login_bloc.dart';
import 'login_view.dart';

class LoginViewRoute extends ViewRoute {
  static const String name = '/login';

  @override
  String get path => name;

  @override
  Route<void>? call(Uri uri, RouteSettings settings) {
    final Object? args = settings.arguments;
    final LoginViewArgs loginViewArgs;
    if (args is LoginViewArgs) {
      loginViewArgs = args;
    } else {
      loginViewArgs = const LoginViewArgs();
    }
    return CupertinoPageRoute(
      builder: (_) => BlocProvider<LoginBloc>(
        create: (_) => GetIt.I<LoginBloc>(),
        child: LoginView(args: loginViewArgs),
      ),
    );
  }
}
