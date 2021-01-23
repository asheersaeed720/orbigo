import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:orbigo/providers/user_provider.dart';

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
                  // myLocationEnabled: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
