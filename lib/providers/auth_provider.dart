import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orbigo/utils/config.dart' as config;
import 'package:orbigo/screens/user_screens/user_screen.dart';
import 'package:orbigo/services/auth_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  RtcEngine _engine;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool isUserExist) {
    _isLoggedIn = isUserExist;
    notifyListeners();
  }

  Map _user = {};
  Map get user => _user;
  setUser() async {
    _user = await _authService.getUser();
    isLoggedIn = _user == null ? false : true;
    notifyListeners();
  }

  // Map _channel = {};
  // Map get channel => _channel;
  // setChannel() async {
  //   _channel = await _authService.getUser();
  //   isLoggedIn = _channel == null ? false : true;
  //   notifyListeners();
  // }

  checkLoginStatus() async {
    return _user = await _authService.getUser();
  }

  login(userCredential, userPvd) {
    return _authService.loginUser(userCredential, userPvd);
  }

  // joinChannel() async {
  //   if (defaultTargetPlatform == TargetPlatform.android) {
  //     await Permission.microphone.request();
  //   }
  //   await _engine.joinChannel(user['jwt'], config.Channel_Name, null, 0);
  // }

  // login(context, userCredential) async {
  //   isLoading = true;
  //   final response = await _authService.loginUser(userCredential);

  //   print(response);

  //   if (response['status'] != false) {
  //     setUser();
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => UserScreen()),
  //       (Route<dynamic> route) => false,
  //     );
  //   } else {
  //     Flushbar(
  //       title: "Failed Login",
  //       message: response['message'],
  //       duration: Duration(seconds: 3),
  //     ).show(context);
  //   }

  //   isLoading = false;
  // }

  logOut(context) async {
    await _authService.logoutUser(context);
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
