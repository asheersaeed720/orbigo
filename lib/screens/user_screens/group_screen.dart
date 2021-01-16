import 'dart:core';

import 'package:flutter/material.dart';
import 'package:orbigo/screens/call_screens/call_sample.dart';
import 'package:orbigo/screens/call_screens/data_channel_sample.dart';
import 'package:orbigo/utils/route_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => new _GroupScreenState();
}

enum DialogDemoAction {
  cancel,
  connect,
}

class _GroupScreenState extends State<GroupScreen> {
  List<RouteItem> items;
  String _server = '145.239.165.237';
  // String _server = '';
  SharedPreferences _prefs;

  bool _datachannel = false;
  @override
  initState() {
    super.initState();
    _initData();
    _initItems();
  }

  _buildRow(context, item) {
    return ListBody(children: <Widget>[
      ListTile(
        title: Text(item.title),
        onTap: () => item.push(context),
        trailing: Icon(Icons.arrow_right),
      ),
      Divider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0.0),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return _buildRow(context, items[i]);
        },
      ),
    );
  }

  _initData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _server = _prefs.getString('server') ?? '145.239.165.237';
      // _server = _prefs.getString('server') ?? 'demo.cloudwebrtc.com';
    });
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        if (value == DialogDemoAction.connect) {
          _prefs.setString('server', _server);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => _datachannel
                  ? DataChannelSample(host: _server)
                  : CallSample(host: _server),
            ),
          );
        }
      }
    });
  }

  _showAddressDialog(context) {
    showDemoDialog<DialogDemoAction>(
        context: context,
        child: AlertDialog(
            title: const Text('Enter server address:'),
            content: TextField(
              onChanged: (String text) {
                setState(() {
                  _server = text;
                });
              },
              decoration: InputDecoration(
                hintText: _server,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, DialogDemoAction.cancel);
                  }),
              FlatButton(
                  child: const Text('CONNECT'),
                  onPressed: () {
                    Navigator.pop(context, DialogDemoAction.connect);
                  })
            ]));
  }

  _initItems() {
    items = <RouteItem>[
      RouteItem(
          title: 'P2P Call Sample',
          subtitle: 'P2P Call Sample.',
          push: (BuildContext context) {
            _datachannel = false;
            _showAddressDialog(context);
          }),
      RouteItem(
          title: 'Data Channel Sample',
          subtitle: 'P2P Data Channel.',
          push: (BuildContext context) {
            _datachannel = true;
            _showAddressDialog(context);
          }),
    ];
  }
}