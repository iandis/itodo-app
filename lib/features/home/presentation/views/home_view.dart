import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/auth/login/presentation/views/login_view.dart';
import '/features/auth/login/presentation/views/login_view_route.dart';
import '/shared/components/app_loading_indicator.dart';
import '../blocs/home_bloc.dart';

part 'home_view.props.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends _HomeViewProps {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is HomeAuthenticated) {
            // TODO(todo-list): create the todo list view and add it here
            return const Center(
              child: Text('Welcome!'),
            );
          } else if (state is HomeUnauthenticated) {
            return Center(
              child: ElevatedButton(
                onPressed: _navigateToLogin,
                child: const Text('Login'),
              ),
            );
          }
          return const Center(
            child: AppLoadingIndicator(),
          );
        },
      ),
    );
  }
}
