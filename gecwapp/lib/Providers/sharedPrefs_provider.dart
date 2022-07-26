import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProvider with ChangeNotifier {
  int? _userAccess;
  String _userName = "";
  int get userAccess => _userAccess!;
  String get userName => _userName;

  Future fetchSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userAccess = prefs.getInt(SharedKeys.userAccess);
    _userName = prefs.getString(SharedKeys.userName) ?? "";
    notifyListeners();
  }
}
