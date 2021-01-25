import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/providers/user_provider.dart';
import 'package:orbigo/utils/config.dart' as config;
import 'package:orbigo/widgets/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class SubscriberScreen extends StatefulWidget {
  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  RtcEngine _engine;

  ClientRole _role = ClientRole.Broadcaster;

  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.Channel_Name);
    this._initEngine();
    this._joinChannel();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.create(config.APP_ID);
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
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
    await _engine.joinChannel(config.Token, config.Channel_Name, null, 0);
  }

  bool isPush = false;

  onPush() {
    setState(() {
      isPush = true;
    });
    AudioCache().play('push_to_talk_audio.wav');
  }

  onUp() {
    setState(() {
      isPush = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final userPvd = watch(userProvider);
          final authPvd = watch(authProvider);
          return FutureBuilder<List<User>>(
            future: userPvd.getUsers(authPvd.user['jwt']),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data;
                // Iterable<String> currentUserId = users
                //     .where((element) =>
                //         element.id.contains(authPvd.user['user']['id']))
                //     .map((e) => int.parse(e.id));

                // print(currentUserId);

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTapDown: (_) => onPush(),
                      onTapUp: (_) => onUp(),
                      child: Card(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          child: ListTile(
                            title: Text(
                              '${users[i].username}',
                              style: TextStyle(fontSize: 18),
                            ),
                            // trailing: GestureDetector(
                            //   onTapDown: (_) => onPush(),
                            //   onTapUp: (_) => onUp(),
                            //   child: isPush
                            //       ? Icon(
                            //           Icons.mic,
                            //           size: 40,
                            //           color: Colors.green,
                            //         )
                            //       : Icon(Icons.mic, size: 30),
                            // ),
                            trailing: isPush
                                ? Icon(
                                    Icons.mic,
                                    size: 40,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.mic, size: 30),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.error}",
                  ),
                );
              }
              return LoadingIndicator();
            },
          );
        },
      ),
    );
  }
}
