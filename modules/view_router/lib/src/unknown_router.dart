import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart'
    show
        Alignment,
        Colors,
        Container,
        EdgeInsets,
        Route,
        RouteSettings,
        Scaffold,
        Text,
        TextStyle;

class UnknownRouter {
  Route<void> call(RouteSettings settings) {
    return CupertinoPageRoute<void>(
      builder: (_) {
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              "Oops.. The page you're looking for does not exist :(",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
