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
  int _page = 0;

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('this is subscriber screen!'),
      ),
    );
  }
}
