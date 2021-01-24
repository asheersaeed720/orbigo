import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';

class GroupDetail extends StatefulWidget {
  RtcEngine _engine;

  final String title;
  final Function function;

  GroupDetail({@required this.title, @required this.function});

  @override
  _GroupDetailState createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;

  @override
  void initState() {
    widget.function();
    super.initState();
  }

  // _switchMicrophone() {
  //   widget._engine?.enableLocalAudio(!openMicrophone)?.then((value) {
  //     setState(() {
  //       openMicrophone = !openMicrophone;
  //     });
  //   })?.catchError((err) {
  //     log('enableLocalAudio $err');
  //   });
  //   print(openMicrophone);
  // }

  // _leaveChannel() async {
  //   await widget._engine?.leaveChannel();
  // }

  bool isSpeaking = false;

  onPush() {
    setState(() {
      isSpeaking = true;
    });
    widget._engine?.enableAudio();
    print(widget._engine?.enableAudio());
  }

  onUp() {
    setState(() {
      isSpeaking = false;
    });
    widget._engine?.disableAudio();
    print(widget._engine?.disableAudio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (_) => onPush(),
          onTapUp: (_) => onUp(),
          child: isSpeaking
              ? Icon(
                  Icons.mic,
                  size: 40,
                )
              : Icon(Icons.mic, size: 30),
        ),
      ),
    );
  }
}
