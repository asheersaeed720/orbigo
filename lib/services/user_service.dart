import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/utils/web_api.dart';

class UserService {
  Future<List<User>> getUsers(userToken) async {
    try {
      var response = await get(
        '${WebAPI.userURL}',
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Please try again!');
      });

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson as List).map((i) => User.fromJson(i)).toList();
      } else {
        throw Exception('Failed to load Users');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
