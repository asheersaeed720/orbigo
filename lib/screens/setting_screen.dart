import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        child: Text('This is setting screen!'),
      ),
    );
  }
}
