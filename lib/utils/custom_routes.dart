import 'package:orbigo/screens/about_screen.dart';
import 'package:orbigo/screens/change_password_screen.dart';
import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/screens/setting_screen.dart';
import 'package:orbigo/screens/user/user_screen.dart';

final customRoutes = {
  // LoginScreen.routeName: (context) => LoginScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  UserScreen.routeName: (context) => UserScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
};
