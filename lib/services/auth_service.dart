import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Future<Map> loginUser(userCredential) async {
  //   var result;

  //   final loginData = {
  //     'phone': userCredential.mobileNo,
  //     'password': userCredential.password,
  //   };

  //   var response = await post(
  //     WebApi.loginURL,
  //     body: loginData,
  //     headers: {'APP_KEY': '${WebApi.appKey}'},
  //   );

  //   if (response.statusCode == 200) {
  //     var responseJson = json.decode(response.body);
  //     saveUser(responseJson);
  //     result = {'status': true, 'message': 'Successful', 'user': responseJson};
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': json.decode(response.body),
  //     };
  //   }
  //   return result;
  // }
}
