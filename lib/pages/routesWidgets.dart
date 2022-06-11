import 'package:flutter/material.dart';
import '../pages/events.dart';
import '../pages/home.dart';
import '../pages/profile.dart';

class RoutesWigets extends StatelessWidget {
  final int index;
  const RoutesWigets({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> routes = [
      Events(),
      Home(),
      const Profile()
    ];
    return routes[index];
  }
}