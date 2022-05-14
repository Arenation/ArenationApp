import 'package:arenation_app/utils/button_style.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:arenation_app/utils/textfield_style.dart';
import 'package:flutter/material.dart';
import "package:arenation_app/utils/text_theme.dart";
import 'package:provider/provider.dart';
import '../services/approutes.dart';
import '../services/http/arenas/getArenas.dart';
import './models/arenas/modelArena.dart';

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
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reto_2',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: AppRoutes().getRoutes),
    );
  }
}
