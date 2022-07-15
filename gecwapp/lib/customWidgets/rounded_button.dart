import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback buttonAction;
  final double _width, _height;
  RoundedButton(this.buttonTitle, this.buttonAction, this._width, this._height);
  // const RoundedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ElevatedButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(width: 2, color: AppColors.primaryColor)),
              )),
          onPressed: buttonAction,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
