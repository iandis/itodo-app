import 'package:flutter/widgets.dart' show Route, RouteSettings;

import 'unknown_router.dart';
import 'view_route.dart';

class ViewRouter {
  factory ViewRouter() => _instance;

  ViewRouter._();

  static final ViewRouter _instance = ViewRouter._();

  final Map<String, ViewRoute> _viewRoutes = <String, ViewRoute>{};

  Route<void> call(RouteSettings settings) {
    final String? name = settings.name;
    Route<void>? generatedRoute;

    if (name != null) {
      final Uri? uri = Uri.tryParse(name);
      if (uri != null) {
        final String routePath = uri.path;
        generatedRoute = _viewRoutes[routePath]?.call(uri, settings);
      }
    }

    return generatedRoute ?? UnknownRouter()(settings);
  }

  void add(ViewRoute viewRoute) {
    _viewRoutes[viewRoute.path] = viewRoute;
  }

  void addAll(List<ViewRoute> viewRoutes) {
    for (final ViewRoute viewRoute in viewRoutes) {
      _viewRoutes[viewRoute.path] = viewRoute;
    }
  }
}
