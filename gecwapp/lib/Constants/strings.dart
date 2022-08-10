import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color.fromRGBO(16, 121, 169, 1);
  static const systemWhite = Color.fromRGBO(253, 253, 253, 1);
  static const systemBlack = Color.fromRGBO(0, 0, 0, 1);
  static const grey1 = Color.fromRGBO(236, 236, 234, 1);
  static const grey2 = Color.fromRGBO(227, 227, 225, 1);
  static const grey3 = Color.fromRGBO(189, 189, 199, 1);
  static const darkGrey = Color.fromRGBO(80, 80, 80, 1);
  static const bicycleGif = Color.fromRGBO(112, 209, 64, 1);
  static const bicycleStop = Color.fromRGBO(234, 8, 45, 1);
}

class SharedKeys {
  static const userAccess = "userAccess";
  static const loginStatus = "isLoggedIn";
  static const userName = "userName";
}

class FirebaseKeys {
  static const bicycle = "bicycle";
  static const verified = "verified";
  static const unverified = "unverified";
  static const notifications = "notifications";
  static const hostels = "hostels";
  static const users = "users";
  static const calendar = "calendar";
  static const clubs = "clubs";
}

enum UserAccess { user, admin, superUser, bicycle }
