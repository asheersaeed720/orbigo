import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orbigo/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();

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
    // _user = await _authService.getUser();
    isLoggedIn = _user == null ? false : true;
    notifyListeners();
  }

  // checkLoginStatus() async {
  //   return _user = await _authService.getUser();
  // }

  // login(context, userCredential) async {
  //   isLoading = true;
  //   final response = await _authService.loginUser(userCredential);

  //   if (response['status'] != false) {
  //     // Timer(
  //     //     Duration(seconds: 5),
  //     //     () => Flushbar(
  //     //           title: "Failed Login",
  //     //           message: 'Timeout',
  //     //           duration: Duration(seconds: 3),
  //     //         ).show(context));
  //     setUser();
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => TabsScreen()),
  //       (Route<dynamic> route) => false,
  //     );
  //   } else {
  //     Flushbar(
  //       title: "Failed Login",
  //       message: response['message']['status'].toString(),
  //       duration: Duration(seconds: 3),
  //     ).show(context);
  //   }

  //   isLoading = false;
  // }

  // logOut(context) async {
  //   await _authService.logoutUser(context);
  //   notifyListeners();
  // }
}
