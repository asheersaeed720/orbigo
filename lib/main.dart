import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbigo/providers/auth_provider.dart';

import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/screens/user_screens/user_screen.dart';
import 'package:orbigo/utils/custom_theme.dart';
import 'package:orbigo/utils/custom_routes.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbigo',
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      // home: LoginScreen(),
      home: Consumer(
        builder: (context, watch, _) {
          final authPvd = watch(authProvider);
          return FutureBuilder(
            future: authPvd.checkLoginStatus(),
            builder: (context, snapshot) {
              return snapshot.hasData ? UserScreen() : LoginScreen();
            },
          );
        },
      ),
      routes: customRoutes,
    );
  }
}
