import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  String token;
  String cookie;

  incrementToken(String token) {
    token = token;
    notifyListeners();
  }

  incrementCookie(String cookie) {
    cookie = cookie;
    notifyListeners();
  }
}
