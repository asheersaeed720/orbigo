import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  static const String routeName = '/events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: Center(
        child: Text('All events will show here!'),
      ),
    );
  }
}
