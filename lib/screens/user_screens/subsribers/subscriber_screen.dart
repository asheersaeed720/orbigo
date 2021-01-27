import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
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
  // RtcEngine _engine;

  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  RtcEngine _engine;

  List<User> users;

  // String channelId = 'global';
  Map<int, bool> userActive = {};
  bool isJoined = false,
      // openMicrophone = true,
      openMicrophone = false,
      enableSpeakerphone = true,
      playEffect = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: channelId);
    this._initEngine();
    // context.read(userProvider).joinChannel();
    _joinChannel();
  }

  @override
  void dispose() {
    super.dispose();
    _engine?.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.create(config.APP_ID);
    this._addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    _engine?.enableLocalAudio(false);
    _engine?.enableAudioVolumeIndication(200, 3, true);
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      audioVolumeIndication: (speakers, volume) {
        if (speakers.length == 0) {
          setState(() {
            userActive = {};
          });
        }
        //log("audioVOL");
        speakers.forEach((speaker) {
          print(
              "uid: ${speaker.uid} vad: ${speaker.vad} vol: ${speaker.volume}");
          if (speaker.volume > 10 && userActive[speaker.uid] != true) {
            setState(() {
              userActive[speaker.uid] = true;
            });
          } else if (speaker.volume < 10 && userActive[speaker.uid] != false) {
            setState(() {
              userActive[speaker.uid] = false;
            });
          }
        });
      },
      remoteAudioStateChanged: (int uid, AudioRemoteState state,
          AudioRemoteStateReason audioRemoteStateReason, int elapsed) {
        if (state == AudioRemoteState.Stopped ||
            audioRemoteStateReason == AudioRemoteStateReason.RemoteMuted ||
            audioRemoteStateReason == AudioRemoteStateReason.RemoteOffline) {
          userActive[uid] = false;
        }
        print(
            "remoteAudioStateChanged: uid: $uid, state: $state, audioRemoteStateReason: $audioRemoteStateReason, elapsed: $elapsed, ");
      },
      error: (code) {
        setState(() {
          print('onError: $code');
        });
      },
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
    var response = await context
        .read(userProvider)
        .createChannel(context.read(authProvider).user['jwt']);
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    print('Joined');
    print(response);
    await _engine?.joinChannel(
        response['channel']['key'],
        response['channel']['Channelname'],
        null,
        response['channel']['user']['id']);
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
  }

  _switchSpeakerphone() {
    _engine?.setEnableSpeakerphone(!enableSpeakerphone)?.then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    })?.catchError((err) {
      log('setEnableSpeakerphone $err');
    });
  }

  _switchMicrophone() {
    _engine?.enableLocalAudio(!openMicrophone)?.then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    })?.catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  bool isPush = false;

  onPush() {
    setState(() {
      isPush = true;
    });
    _engine?.enableLocalAudio(true);
    setState(() {
      openMicrophone = true;
    });
    //this._switchMicrophone();
    // AudioCache().play('push_to_talk_audio.wav');
    //   widget._engine?.enableLocalAudio(!openMicrophone)?.then((value) {
    //     setState(() {
    //       // openMicrophone = !openMicrophone;
    //       openMicrophone = true;
    //     });
    //   })?.catchError((err) {
    //     log('enableLocalAudio $err');
    //   });
  }

  onUp() {
    setState(() {
      isPush = false;
    });
    _engine?.enableLocalAudio(false);
    // widget._engine?.disableAudio()?.then((value) {
    //   setState(() {
    //     openMicrophone = !openMicrophone;
    //   });
    // })?.catchError((err) {
    //   log('enableLocalAudio $err');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final userPvd = watch(userProvider);
          final authPvd = watch(authProvider);
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /* RaisedButton(
                onPressed: this._switchMicrophone,
                child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
              ), */
              GestureDetector(
                onTapDown: (_) => onPush(),
                onTapUp: (_) => onUp(),
                onTapCancel: () => onUp(),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: ListTile(
                      title: Text(
                        '${authPvd.user['user']['username']} (Me)',
                        style: TextStyle(fontSize: 18),
                      ),
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
              ),
              Expanded(
                child: FutureBuilder<List<User>>(
                  future: userPvd.getUsers(authPvd),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      users = snapshot.data;

                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 6),
                              child: ListTile(
                                title: Text(
                                  '${users[i].username}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: Icon(
                                  Icons.mic,
                                  size: 30,
                                  color: (userActive[users[i].id] ?? false)
                                      ? Colors.green
                                      : Colors.grey,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
