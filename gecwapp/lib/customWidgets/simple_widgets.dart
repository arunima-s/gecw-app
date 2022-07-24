import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
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

class GWRoundedIcon extends StatelessWidget {
  final VoidCallback function;
  final Icon icon;
  GWRoundedIcon(this.function, this.icon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: icon,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.white, // <-- Button color
        onPrimary: AppColors.primaryColor, // <-- Splash color
      ),
    );
  }
}
