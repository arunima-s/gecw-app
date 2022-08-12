import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecwapp/Providers/custom-ads-provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExitAlert extends StatelessWidget {
  // const AlertScreen({Key? key}) : super(key: key);
  // final VoidCallback cancelFn, okFn;
  var isAdmin;
  final String alertMessage, alertTitle, buttonTitle;
  ExitAlert(this.alertMessage, this.alertTitle, this.buttonTitle);

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    final ads = context.watch<AdsProvider>().ads;
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
            ads.first.status
                ? ImageBanner(
                    ads.first.link, screenHeight * 0.6, screenWidth * 0.7)
                : SizedBox(),
            // Image.asset('assets/images/sad48.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              alertTitle,
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
                  RoundedButton("Cancel", () {
                    Navigator.pop(context);
                  }, screenWidth * 0.2, screenHeight * 0.06),
                  RoundedButton("Rate Us", () async {
                    await launch(
                        "https://play.google.com/store/apps/details?id=com.inceptra.haiku",
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true);
                  }, screenWidth * 0.2, screenHeight * 0.06),
                  RoundedButton(buttonTitle, () {
                    SystemNavigator.pop();
                  }, screenWidth * 0.2, screenHeight * 0.06)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
