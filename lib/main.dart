import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:orbigo/screens/login_screen.dart';
import 'package:orbigo/utils/custom_theme.dart';
import 'package:orbigo/utils/custom_routes.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbigo',
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      home: LoginScreen(),
      routes: customRoutes,
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _page = 0;
//   GlobalKey _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Orbigo',
//       home: Scaffold(
//         body: Container(
//           color: Colors.blueAccent,
//           child: Center(
//             child: Column(
//               children: <Widget>[
//                 Text(_page.toString(), textScaleFactor: 10.0),
//                 RaisedButton(
//                   child: Text('Go To Page of index 1'),
//                   onPressed: () {
//                     final CurvedNavigationBarState navBarState =
//                         _bottomNavigationKey.currentState;
//                     navBarState.setPage(1);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           key: _bottomNavigationKey,
//           index: 0,
//           height: 50.0,
//           items: <Widget>[
//             Icon(Icons.add, size: 30),
//             Icon(Icons.list, size: 30),
//             Icon(Icons.compare_arrows, size: 30),
//             Icon(Icons.call_split, size: 30),
//             Icon(Icons.perm_identity, size: 30),
//           ],
//           color: Colors.white,
//           buttonBackgroundColor: Colors.white,
//           backgroundColor: Colors.blueAccent,
//           animationCurve: Curves.easeInOut,
//           animationDuration: Duration(milliseconds: 300),
//           onTap: (index) {
//             setState(() {
//               _page = index;
//             });
//           },
//           letIndexChange: (index) => true,
//         ),
//       ),
//     );
//   }
// }
