import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/utils/web_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<Map> loginUser(UserCredential userCredential) async {
    var result;

    final loginData = {
      'identifier': userCredential.usernameOrEmail,
      'password': userCredential.password,
    };

    var response = await post(
      WebAPI.loginURL,
      body: loginData,
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      saveUser(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else if (response.statusCode == 400) {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'][0]['messages'][0]
            ['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }
    return result;
  }

  saveUser(userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userData', jsonEncode(userData));
  }

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString('userData');
    if (userData != null) {
      Map user = json.decode(userData);
      print(user);
      return user;
    }
  }

  logoutUser(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userData');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
