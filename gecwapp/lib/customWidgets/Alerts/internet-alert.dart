import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecwapp/Providers/custom-ads-provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/main.dart';
import 'package:provider/provider.dart';

class InternetAlert extends StatelessWidget {
  // const AlertScreen({Key? key}) : super(key: key);
  // final VoidCallback cancelFn, okFn;
  var isAdmin;
  // final String alertMessage, alertTitle, buttonTitle;
  // InternetAlert(this.alertMessage, this.alertTitle, this.buttonTitle);

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
            Text(
              "Please connect to Internet for using this feature",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedButton("Exit", () {
                    SystemNavigator.pop();
                  }, screenWidth * 0.3, screenHeight * 0.07),
                  /////
                  /////
                  /////
                  ////
                  RoundedButton("Restart app", () {
                    RestartWidget.restartApp(context);
                  }, screenWidth * 0.3, screenHeight * 0.07)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
