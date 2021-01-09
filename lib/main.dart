import 'package:flutter/material.dart';

import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/utils/custom_theme.dart';
import 'package:orbigo/utils/custom_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hani Almutairi Logistic',
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: LoginScreen(),
      routes: customRoutes,
    );
  }
}
