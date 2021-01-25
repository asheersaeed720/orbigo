import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/providers/user_provider.dart';
import 'package:orbigo/utils/config.dart';
import 'package:orbigo/widgets/loading_indicator.dart';

class SubscriberScreen extends StatefulWidget {
  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  // RtcEngine _engine;
  // bool isSpeaking = false;

  // onPush() {
  //   print('Pushing');
  //   setState(() {
  //     isSpeaking = true;
  //   });
  // }

  // onUp() {
  //   print('OnCancel');
  //   setState(() {
  //     isSpeaking = false;
  //   });
  // }

  // final _users = <int>[];
  // final _infoStrings = <String>[];
  // bool muted = false;

  // @override
  // void dispose() {
  //   // clear users
  //   _users.clear();
  //   // destroy sdk
  //   _engine.leaveChannel();
  //   _engine.destroy();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // initialize agora sdk
  //   initialize();
  // }

  // Future<void> initialize() async {
  //   if (APP_ID.isEmpty) {
  //     setState(() {
  //       _infoStrings.add(
  //         'APP_ID missing, please provide your APP_ID in settings.dart',
  //       );
  //       _infoStrings.add('Agora Engine is not starting');
  //     });
  //     return;
  //   }

  //   await _initAgoraRtcEngine();
  //   _addAgoraEventHandlers();
  //   await _engine.enableWebSdkInteroperability(true);
  //   VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
  //   configuration.dimensions = VideoDimensions(1920, 1080);
  //   await _engine.setVideoEncoderConfiguration(configuration);
  //   // await _engine.joinChannel(Token, widget.channelName, null, 0);
  // }

  // // /// Create agora sdk instance and initialize
  // // Future<void> _initAgoraRtcEngine() async {
  // //   _engine = await RtcEngine.create(APP_ID);
  // //   await _engine.enableVideo();
  // //   // await _engine.enableAudio();
  // //   await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
  // //   // await _engine.setClientRole(widget.role);
  // // }

  // /// Add agora event handlers
  // void _addAgoraEventHandlers() {
  //   _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
  //     setState(() {
  //       final info = 'onError: $code';
  //       _infoStrings.add(info);
  //     });
  //   }, joinChannelSuccess: (channel, uid, elapsed) {
  //     setState(() {
  //       final info = 'onJoinChannel: $channel, uid: $uid';
  //       _infoStrings.add(info);
  //     });
  //   }, leaveChannel: (stats) {
  //     setState(() {
  //       _infoStrings.add('onLeaveChannel');
  //       _users.clear();
  //     });
  //   }, userJoined: (uid, elapsed) {
  //     setState(() {
  //       final info = 'userJoined: $uid';
  //       _infoStrings.add(info);
  //       _users.add(uid);
  //     });
  //   }, userOffline: (uid, elapsed) {
  //     setState(() {
  //       final info = 'userOffline: $uid';
  //       _infoStrings.add(info);
  //       _users.remove(uid);
  //     });
  //   }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
  //     setState(() {
  //       final info = 'firstRemoteVideo: $uid ${width}x $height';
  //       _infoStrings.add(info);
  //     });
  //   }));
  // }

  bool isPush = false;

  onPush() {
    setState(() {
      isPush = true;
    });
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
                    return Card(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                        child: ListTile(
                          title: Text(
                            '${users[i].username}',
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: GestureDetector(
                            onTapDown: (_) => onPush(),
                            onTapUp: (_) => onUp(),
                            child: isPush
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
