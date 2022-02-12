part of '../views/login_view.dart';

class _LoginSuccessContainer extends StatelessWidget {
  const _LoginSuccessContainer({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String? username;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        username != null ? 'Hello, $username!' : 'Hello there!',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
