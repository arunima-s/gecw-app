import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/values.dart';

class GWSpace extends StatelessWidget {
  final double _height, _width;
  GWSpace(this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
    );
  }
}
