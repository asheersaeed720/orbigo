import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value += 1;
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider((ref) => UserNotifier());
