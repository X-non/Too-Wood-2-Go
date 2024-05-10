import 'package:flutter/material.dart';

class DistanceNotifier extends ChangeNotifier {
  double _distance = 2000;

  double get distance => _distance;

  void updateDistance(double newDistance) {
    _distance = newDistance;
    notifyListeners();
  }
}
