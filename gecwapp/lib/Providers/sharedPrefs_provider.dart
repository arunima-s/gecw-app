import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProvider with ChangeNotifier {
  int? _userAccess;
  int get userAccess => _userAccess!;

  Future fetchSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userAccess = prefs.getInt(SharedKeys.userAccess);
    notifyListeners();
  }
}
