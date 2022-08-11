import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';

class MarkAlert extends StatelessWidget {
  // const AlertScreen({Key? key}) : super(key: key);
  final String alertMessage1, alertMessage2, alertTitle;
  MarkAlert(this.alertMessage1, this.alertMessage2, this.alertTitle);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      content: Container(
        // height: screenHeight * 0.3,
        width: screenWidth * 0.9,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/images/sad48.png'),
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
              alertMessage1,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              alertMessage2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            //Button
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // RoundedButton(
                  //     "Cancel",
                  //     //  (() {
                  //     //   Navigator.pop(context);
                  //     // }),
                  //     cancelFn,
                  //     screenWidth * 0.25,
                  //     screenHeight * 0.06),
                  RoundedButton("OK",
                      // () async {
                      //   SharedPreferences prefs =
                      //       await SharedPreferences.getInstance();
                      //   prefs.setBool(SharedKeys.loginStatus, false);
                      //   await FirebaseAuth.instance.signOut().whenComplete(() {
                      //     RestartWidget.restartApp(context);
                      //   });
                      // },
                      () {
                    Navigator.pop(context);
                  }, screenWidth * 0.25, screenHeight * 0.06)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
