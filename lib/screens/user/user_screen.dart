import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:orbigo/screens/events_screen.dart';
import 'package:orbigo/screens/map_screen.dart';
import 'package:orbigo/screens/user/group_screen.dart';
import 'package:orbigo/screens/user/subscriber_screen.dart';
import 'package:orbigo/widgets/app_drawer.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = '/user';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
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
                icon: Icon(Icons.map),
                onPressed: () {
                  Navigator.of(context).pushNamed(GoogleMapScreen.routeName);
                },
              ),
              IconButton(
                icon: Icon(Icons.event),
                onPressed: () {
                  Navigator.of(context).pushNamed(EventsScreen.routeName);
                },
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
      ),
    );
  }
}
