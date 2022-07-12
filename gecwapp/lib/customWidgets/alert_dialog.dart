import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertScreen extends StatelessWidget {
  // const AlertScreen({Key? key}) : super(key: key);
  var isAdmin;
  final String alertMessage, alertTitle, buttonTitle;
  AlertScreen(this.alertMessage, this.alertTitle, this.buttonTitle);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      content: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/sad48.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              alertTitle,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              alertMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            //Button
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton("Cancel", (() {
                    Navigator.pop(context);
                  }), screenWidth * 0.4, screenHeight * 0.06),
                  RoundedButton(buttonTitle, () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool(SharedKeys.loginStatus, false);
                    await FirebaseAuth.instance.signOut().whenComplete(() {
                      RestartWidget.restartApp(context);
                    });
                  }, screenWidth * 0.4, screenHeight * 0.06)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
