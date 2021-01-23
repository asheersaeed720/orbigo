import 'dart:math';

import 'package:flutter/material.dart';

class SubscriberScreen extends StatefulWidget {
  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  bool isSpeaking = false;

  onPush() {
    print('Pushing');
    setState(() {
      isSpeaking = true;
    });
  }

  onUp() {
    print('OnCancel');
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Subsriber will show there soon!'),
      ),
    );
  }
}
