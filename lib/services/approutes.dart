import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/arena.dart';
import '../pages/profile.dart';

class AppRoutes {
  Map<String, WidgetBuilder>? _routes;

  AppRoutes() {
    createRoutes();
  }

  void createRoutes() {
    _routes = {
      '/': (context) => Login(),
      "/home": (context) => Home(),
      '/register': (context) => Register(),
      '/arena': (context) => const Arena(),
      '/profile': (context) => Profile(),
    };
  }

  get getRoutes => _routes;
}
