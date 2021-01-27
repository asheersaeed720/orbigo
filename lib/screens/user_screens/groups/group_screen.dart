import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:orbigo/screens/user_screens/groups/audio_group_detail.dart';
import 'package:orbigo/screens/user_screens/groups/video_group_detail.dart';
import 'package:orbigo/utils/config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => new _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 1,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoGroup(),
                  ),
                );
              },
              title: Text('Join Video Group'),
              trailing: Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
    );
  }
}
