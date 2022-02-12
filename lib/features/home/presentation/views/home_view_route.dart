import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:view_router/view_router.dart';

import '../blocs/home_bloc.dart';
import 'home_view.dart';

class HomeViewRoute extends ViewRoute {
  static const String name = '/';

  @override
  String get path => name;

  @override
  Route<void>? call(Uri uri, RouteSettings settings) {
    return CupertinoPageRoute(
      builder: (_) => BlocProvider<HomeBloc>(
        create: (_) => GetIt.I<HomeBloc>(),
        child: const HomeView(),
      ),
    );
  }
}
