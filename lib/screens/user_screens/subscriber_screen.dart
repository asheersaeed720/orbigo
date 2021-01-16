import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

// class SubscriberScreen extends StatefulWidget {
//   @override
//   _SubscriberScreenState createState() => _SubscriberScreenState();
// }

// class _SubscriberScreenState extends State<SubscriberScreen> {
//   int _page = 0;

//   GlobalKey _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text(_page.toString(), textScaleFactor: 10.0),
//             RaisedButton(
//               child: Text('Go To Page of index 1'),
//               onPressed: () {
//                 final CurvedNavigationBarState navBarState =
//                     _bottomNavigationKey.currentState;
//                 navBarState.setPage(1);
//               },
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         index: 0,
//         height: 50.0,
//         items: <Widget>[
//           Icon(Icons.add, size: 30),
//           Icon(Icons.list, size: 30),
//           Icon(Icons.compare_arrows, size: 30),
//           Icon(Icons.call_split, size: 30),
//           Icon(Icons.perm_identity, size: 30),
//         ],
//         color: Colors.white,
//         buttonBackgroundColor: Colors.white,
//         backgroundColor: Theme.of(context).primaryColor,
//         animationCurve: Curves.easeInOut,
//         animationDuration: Duration(milliseconds: 300),
//         onTap: (index) {
//           setState(() {
//             _page = index;
//           });
//         },
//         letIndexChange: (index) => true,
//       ),
//     );
//   }
// }

class SubscriberScreen extends StatefulWidget {
  @override
  _SubscriberScreenState createState() => _SubscriberScreenState();
}

class _SubscriberScreenState extends State<SubscriberScreen> {
  bool isVoiceEnable = false;

  testVoice() {
    setState(() {
      isVoiceEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: ListTile(
              onLongPress: () {
                testVoice();
              },
              leading: CircleAvatar(
                backgroundColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Text(
                  'Y',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text('You'),
              trailing: Container(
                padding: EdgeInsets.all(8),
                // color: Colors.grey,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.mic,
                  size: isVoiceEnable ? 30 : 24,
                  color: isVoiceEnable ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                // backgroundColor:
                //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
                backgroundColor: Colors.grey,
                child: Text(
                  'U',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text('User 1'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.location_on),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
