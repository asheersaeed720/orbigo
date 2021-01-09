import 'package:flutter/material.dart';

class CustomColor {
  const CustomColor();

  static const Color gradientStart = const Color(0xFFF9A773);
  static const Color gradientEnd = const Color(0xFFEF4472);

  static const primaryGradient = const LinearGradient(
    colors: const [gradientStart, gradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Map<int, Color> color = {
  50: Color.fromRGBO(8, 45, 74, .1),
  100: Color.fromRGBO(8, 45, 74, .2),
  200: Color.fromRGBO(8, 45, 74, .3),
  300: Color.fromRGBO(8, 45, 74, .4),
  400: Color.fromRGBO(8, 45, 74, .5),
  500: Color.fromRGBO(8, 45, 74, .6),
  600: Color.fromRGBO(8, 45, 74, .7),
  700: Color.fromRGBO(8, 45, 74, .8),
  800: Color.fromRGBO(8, 45, 74, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFF1D1D38, color);

final customTheme = ThemeData(
  primarySwatch: customPrimaryColor,
  accentColor: Colors.blue,
  errorColor: Colors.redAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ProximaNova',
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 22.0,
      fontFamily: 'ProximaNova',
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(fontSize: 14.0),
  ),
);
