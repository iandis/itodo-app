part of 'home_view.dart';

abstract class _HomeViewProps extends State<HomeView> {
  late final HomeBloc _homeBloc = context.read<HomeBloc>();

  void _navigateToLogin() {
    final LoginViewArgs args = LoginViewArgs(
      onLoggedIn: (BuildContext context) {
        Navigator.of(context).pop();
      },
    );

    Navigator.of(context).pushNamed(
      LoginViewRoute.name,
      arguments: args,
    );
  }

  void _logout() {
    _homeBloc.add(HomeLogoutEvent());
  }
}
