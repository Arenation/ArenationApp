import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/register.dart';
import '../pages/arena.dart';
import '../pages/profile.dart';
import '../pages/profile/information.dart';
import '../pages/profile/security.dart';
import '../pages/profile/payment.dart';
import '../pages/events.dart';
import '../pages/principal.dart';

class AppRoutes {
  Map<String, WidgetBuilder>? _routes;

  AppRoutes() {
    createRoutes();
  }

  void createRoutes() {
    _routes = {
      '/': (context) => Login(),
      "/home": (context) => Principal(),
      '/register': (context) => Register(),
      '/arena': (context) => Arena(),
      '/profile': (context) => const Profile(),
      '/profile/information': (context) => const Information(),
      '/profile/security': (context) => const Security(),
      '/profile/payment': (context) => const Payment(),
      '/events': (context) => Events(),
    };
  }

  get getRoutes => _routes;
}
