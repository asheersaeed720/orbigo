import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:orbigo/screens/events_screen.dart';
import 'package:orbigo/screens/map_screen.dart';
import 'package:orbigo/screens/user/group_screen.dart';
import 'package:orbigo/screens/user/subscriber_screen.dart';
import 'package:orbigo/screens/user/user_profile_screen.dart';
import 'package:orbigo/widgets/app_drawer.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = '/user';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // leading: _isSearching ? const BackButton() : AppDrawer(),
            title: _isSearching ? _buildSearchField() : Text('User'),

            bottom: TabBar(
              tabs: [
                Tab(text: "SUBSCRIBER"),
                Tab(text: "GROUP"),
              ],
            ),
            actions: _buildActions(),
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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
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
        onPressed: _startSearch,
      ),
      IconButton(
        icon: Icon(Icons.account_circle_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed(UserProfileScreen.routeName);
        },
      ),
      // PopupMenuButton<String>(
      //   onSelected: handleClick,
      //   itemBuilder: (BuildContext context) {
      //     return {
      //       'Logout',
      //       'Settings',
      //     }.map((String choice) {
      //       return PopupMenuItem<String>(
      //         value: choice,
      //         child: Text(choice),
      //       );
      //     }).toList();
      //   },
      // ),
    ];
  }

  // void handleClick(String value) {
  //   switch (value) {
  //     case 'Logout':
  //       print('Logout');
  //       break;
  //     case 'Settings':
  //       print('Settings');
  //       break;
  //   }
  // }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
