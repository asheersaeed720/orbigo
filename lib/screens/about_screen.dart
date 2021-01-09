import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        child: Text('This is About Screen!'),
      ),
    );
  }
}
