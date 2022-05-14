import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/login.dart';

class AppRoutes {
  Map<String, WidgetBuilder>? _routes;

  AppRoutes() {
    createRoutes();
  }

  void createRoutes() {
    _routes = {
      '/': (context) => Login(),
      "/home": (context) => Home(),
    };
  }

  get getRoutes => _routes;
}
