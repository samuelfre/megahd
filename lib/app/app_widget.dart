import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'Mega HD Filmes',
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
