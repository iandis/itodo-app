import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:view_router/view_router.dart';

import 'core/bindings/di.dart';
import 'core/bindings/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initDI();
  initRoutes();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'itodo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: ViewRouter(),
    );
  }
}
