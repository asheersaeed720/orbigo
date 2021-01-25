import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/services/user_service.dart';
import 'package:orbigo/utils/config.dart' as config;

import 'package:permission_handler/permission_handler.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class UserProvider extends ChangeNotifier {
  UserService _userService = UserService();

  int _value = 0;
  int get value => _value;

  void increment() {
    _value += 1;
    notifyListeners();
  }

  Future<Map> createChannel(userToken) async {
    return _userService.createUserChannel(userToken);
  }

  Future<List<User>> getUsers(userToken) async {
    return _userService.getUsers(userToken);
  }

  LatLng initialcameraposition = LatLng(24.8607, 67.0011);

  GoogleMapController _controller;

  Location _location = Location();

  Marker marker;

  onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 5),
        ),
      );
    });
  }
}

final userProvider = ChangeNotifierProvider((ref) => UserProvider());
