// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:orbigo/providers/user_provider.dart';

// class GoogleMapScreen extends StatelessWidget {
//   static const String routeName = '/google-map';

//   @override
//   Widget build(BuildContext context) {
//     LatLng initialcameraposition = LatLng(51.5074, 0.1278);

//     GoogleMapController _controller;

//     Location _location = Location();

//     Marker marker;

//     onMapCreated(GoogleMapController _cntlr) {
//       _controller = _cntlr;
//       _location.onLocationChanged.listen((l) {
//         _controller.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 5),
//           ),
//         );
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Consumer(
//           builder: (context, watch, child) {
//             final userNotifier = watch(userProvider);
//             return Stack(
//               children: [
//                 GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: initialcameraposition,
//                     zoom: 15,
//                   ),
//                   mapType: MapType.normal,
//                   onMapCreated: onMapCreated,
//                   myLocationEnabled: true,
//                   // zoomControlsEnabled: true,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/google-map';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<MapScreen> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  Future<void> _handleLocation() async {
    final status = await Permission.location.request();
    print(status);
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.location.request();
    print(status);
  }

  @override
  void initState() {
    super.initState();
    _handleLocation();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              if (_currentPosition != null &&
                                  _currentAddress != null)
                                Text(_currentAddress,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
