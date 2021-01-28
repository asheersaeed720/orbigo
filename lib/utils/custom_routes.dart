import 'package:orbigo/screens/about_screen.dart';
import 'package:orbigo/screens/change_password_screen.dart';
import 'package:orbigo/screens/events_screen.dart';
import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/screens/map_screen.dart';
import 'package:orbigo/screens/setting_screen.dart';
import 'package:orbigo/screens/user_screens/subsribers/subsriber_chat_screen.dart';
import 'package:orbigo/screens/user_screens/user_profile_screen.dart';
import 'package:orbigo/screens/user_screens/user_screen.dart';

final customRoutes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  UserScreen.routeName: (context) => UserScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
  MapScreen.routeName: (context) => MapScreen(),
  EventsScreen.routeName: (context) => EventsScreen(),
  UserProfileScreen.routeName: (context) => UserProfileScreen(),
  SubsriberChatScreen.routeName: (context) => SubsriberChatScreen(),
};
