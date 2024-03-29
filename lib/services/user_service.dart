import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:orbigo/models/chat.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/services/auth_service.dart';
import 'package:orbigo/utils/config.dart';
import 'package:orbigo/utils/web_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<Map> createUserChannel(userToken) async {
    var result;

    var response = await post(
      WebAPI.createChannelURL,
      headers: {
        'Authorization': 'Bearer $userToken',
      },
      body: {
        'channelname': '$Channel_Name',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      saveChannel(responseJson);
      result = {
        'status': true,
        'message': 'Successful',
        'channel': responseJson
      };
    } else if (response.statusCode == 400) {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'][0]['messages'][0]
            ['message'],
      };
      print(json.decode(response.body));
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
      print(json.decode(response.body));
    }
    return result;
  }

  saveChannel(channelData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('channelData', jsonEncode(channelData));
  }

  getChannel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var channelData = preferences.getString('channelData');
    if (channelData != null) {
      Map channel = json.decode(channelData);
      return channel;
    }
  }

  // Future<List<User>> getUsers(AuthProvider user) async {
  //   try {
  //     var response = await get(
  //       '${WebAPI.userURL}?id_ne=${user.user['user']['id']}',
  //       headers: {
  //         'Authorization': 'Bearer ${user.user['jwt']}',
  //       },
  //     ).timeout(const Duration(seconds: 10), onTimeout: () {
  //       throw TimeoutException('Please try again!');
  //     });

  //     if (response.statusCode == 200) {
  //       var responseJson = json.decode(response.body);
  //       return (responseJson as List).map((i) => User.fromJson(i)).toList();
  //     } else {
  //       throw Exception('Failed to load Users');
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection');
  //   }
  // }

  Future<List<User>> getUser(AuthProvider userToken, uid) async {
    try {
      var response = await get(
        '${WebAPI.userURL}/$uid',
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

  Future<List<Chat>> getMessages(AuthProvider authPvd) async {
    try {
      var response = await get(
        '${WebAPI.chatMessagesURL}/?channel_eq=global&_limit=20&_sort=created_at:DESC',
        headers: {
          'Authorization': 'Bearer ${authPvd.user['jwt']}',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Please try again!');
      });

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List).map((i) => Chat.fromJson(i)).toList();
      } else {
        throw Exception('Failed to load Messages');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<Map> sendUserMessages(AuthProvider authPvd, textMessage) async {
    var result;

    // var body = jsonEncode({
    //   {
    //     "text": "$textMessage",
    //     "users": "${authPvd.user['user']['id']}",
    //     "channel": "global"
    //   }
    // });

    var body = """{
        "text": "$textMessage",
        "users": "${authPvd.user['user']['id']}",
        "channel": "global"
      }""";

    print('Before hit: $body');

    var response = await post(
      WebAPI.loginURL,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjExNTYxMDk5LCJleHAiOjE2MTQxNTMwOTl9.ilUvd0DYH0hRh-Y5sRlmCxCmQtvZu1Z19pox09Sa-oE',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);

      // userPvd.createChannel(responseJson['jwt']);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else if (response.statusCode == 400) {
      print(response.body);
      result = {
        'status': false,
        'message': json.decode(response.body)['message'][0]['messages'][0]
            ['message'],
      };
    } else {
      print(response.body);
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }
    return result;
  }
}
