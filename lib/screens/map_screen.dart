import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:orbigo/providers/user_provider.dart';

// class GoogleMapScreen extends StatefulWidget {
//   static const String routeName = '/google-map';

//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   LatLng _initialcameraposition = LatLng(59.3293, 18.0686);
//   GoogleMapController _controller;
//   Location _location = Location();

//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               onMapCreated: _onMapCreated,
//               myLocationEnabled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class GoogleMapScreen extends StatelessWidget {
  static const String routeName = '/google-map';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Consumer(
          builder: (context, watch, child) {
            final userNotifier = watch(userProvider);
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: userNotifier.initialcameraposition,
                  ),
                  mapType: MapType.normal,
                  onMapCreated: userNotifier.onMapCreated,
                  myLocationEnabled: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
