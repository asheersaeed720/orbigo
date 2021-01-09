import 'package:flutter/material.dart';
import 'package:orbigo/screens/user/group_screen.dart';
import 'package:orbigo/screens/user/subscriber_screen.dart';
import 'package:orbigo/widgets/app_drawer.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("User"),
          bottom: TabBar(
            tabs: [
              Tab(text: "SUBSCRIBER"),
              Tab(text: "GROUP"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.group),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.event),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: TabBarView(
          children: [
            SubscriberScreen(),
            GroupScreen(),
          ],
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}
