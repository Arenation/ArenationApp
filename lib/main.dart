import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/approutes.dart';
import '../services/http/arenas/getArenas.dart';
import '../services/http/users/getUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetArenas()),
        ChangeNotifierProvider(create: (_) => GetUser())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Arenation',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: AppRoutes().getRoutes),
    );
  }
}
