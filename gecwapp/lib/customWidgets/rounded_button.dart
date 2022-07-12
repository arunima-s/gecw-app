import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback buttonAction;
  RoundedButton(this.buttonTitle, this.buttonAction);
  // const RoundedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(width: 2, color: Colors.blue)),
            )),
        onPressed: buttonAction,
        child: Text(
          buttonTitle,
          style: TextStyle(color: Colors.blue[700]),
        ));
  }
}
