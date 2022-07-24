import 'package:flutter/material.dart';

class GWValuesProvider with ChangeNotifier {
  double _height = 0;
  double _width = 0;

  double get height => _height;
  double get width => _width;

  Future setScreenSize(double height, width) async {
    _width = width;
    _height = height;
  }

  // void setScreenWidth(double width) {
  //   _width = width;
  //   notifyListeners();
  // }
}
