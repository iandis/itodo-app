import 'package:flutter/material.dart';

abstract class ViewRoute {
  String get path;

  Route<void>? call(Uri uri, RouteSettings settings);
}
