import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  String _token = '';
  String _cookie = '';
  String get token => _token;
  String get cookie => _cookie;
  incrementToken(String token) {
    print('token');
    print(token);
    _token = token;
    notifyListeners();
  }

  incrementCookie(String cookie) {
    print('cookie');
    print(cookie);
    _cookie = cookie;
    notifyListeners();
  }
}
