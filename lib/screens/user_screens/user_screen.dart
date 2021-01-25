import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/providers/user_provider.dart';
import 'package:orbigo/screens/events_screen.dart';
import 'package:orbigo/screens/map_screen.dart';
import 'package:orbigo/screens/user_screens/groups/group_screen.dart';
import 'package:orbigo/screens/user_screens/subsribers/subscriber_screen.dart';
import 'package:orbigo/screens/user_screens/user_profile_screen.dart';
import 'package:orbigo/utils/config.dart';
import 'package:orbigo/widgets/app_drawer.dart';
import 'package:orbigo/widgets/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = '/user';

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
        hintText: "Searching...",
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
        icon: Icon(Icons.location_on),
        onPressed: () {
          Navigator.of(context).pushNamed(MapScreen.routeName);
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
    ];
  }

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
