part of 'login_view.dart';

abstract class _LoginViewProps extends State<LoginView> {
  late final LoginBloc _loginBloc = context.read<LoginBloc>();

  @override
  void initState() {
    super.initState();
    _loginWithGoogle();
  }

  void _loginWithGoogle() {
    if (!_loginBloc.isClosed && _loginBloc is! LoginLoading) {
      _loginBloc.add(LoginWithGoogleEvent());
    }
  }

  void _onLoggedIn(String? email) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Signed in as ${email ?? '[unknown user]'}'),
        ),
      );

    Future<void>.delayed(
      const Duration(seconds: 1),
      () => widget.args.onLoggedIn?.call(context),
    );
  }

  void _onError(String error) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          content: Text(error),
        ),
      );
  }
}
