import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  void toggleLogin() {
    _loggedIn = !_loggedIn;
    notifyListeners();
  }
}
