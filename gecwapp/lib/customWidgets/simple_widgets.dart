import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/values.dart';

class GWSpace extends StatelessWidget {
  final double _height, _width;
  GWSpace(this._height, this._width);
  final sHeight = GWValues().getScreenSizes[0];
  final sWidth = GWValues().getScreenSizes[1];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height * sHeight,
      width: _width * sWidth,
    );
  }
}
