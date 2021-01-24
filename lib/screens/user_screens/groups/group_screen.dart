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
  RtcEngine _engine;

  @override
  _GroupScreenState createState() => new _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  // String channelId = config.channelId;
  String channelId = 'testchannel1';

  // String channelName = 'testing5';
  String uid;

  ClientRole _role = ClientRole.Broadcaster;

  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    widget._engine?.destroy();
  }

  _initEngine() async {
    widget._engine = await RtcEngine.create(config.APP_ID);
    this._addListeners();

    await widget._engine.enableAudio();
    await widget._engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await widget._engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    widget._engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    await widget._engine?.joinChannel(config.Token, channelId, null, 0);
  }

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
                    builder: (context) => GroupDetail(
                      title: 'Audio Group',
                      function: _joinChannel,
                    ),
                  ),
                );
              },
              title: Text('Audio Group'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          Card(
            elevation: 1,
            child: ListTile(
              onTap: () {
                onJoin();
              },
              title: Text('Video Group'),
              trailing: Icon(Icons.arrow_forward),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // await _handleCameraAndMic(PermissionGroup.camera);
    // await _handleCameraAndMic(PermissionGroup.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoGroup(
          // channelName: channelName,
          channelName: channelId,
          role: _role,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
