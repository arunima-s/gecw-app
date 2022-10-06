import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Utilities/popup_messages.dart';
import 'package:gecwapp/main.dart';
import 'package:gecwapp/screens/links-screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Alerts/alert_dialog.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'HAIKU',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/graphic.png'))),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Our developers'),
          //   onTap: () {
          //     Messages.displayMessage(context, "");
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              share();
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () async {
              await launch(
                "https://docs.google.com/forms/d/e/1FAIpQLSeRhAUgDzIVP_yqlV1LFAsSeQ2nfEQh15aodJr1wvvcOm4HrA/viewform?usp=sf_link",
                // forceSafariVC: true,
                // forceWebView: true,
                // enableJavaScript: true
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Useful Links'),
            onTap: () async {
              // await launch(
              //     "https://docs.google.com/forms/d/e/1FAIpQLSeRhAUgDzIVP_yqlV1LFAsSeQ2nfEQh15aodJr1wvvcOm4HrA/viewform?usp=sf_link",
              //     forceSafariVC: true,
              //     forceWebView: true,
              //     enableJavaScript: true);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LinkScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            // onTap: () => {Navigator.of(context).pop()},
            onTap: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext buildContext) {
                    return AlertScreen(
                        "You can always return using your google account",
                        "Are you leaving??",
                        "Logout", () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool(SharedKeys.loginStatus, false);
                      await FirebaseAuth.instance.signOut().whenComplete(() {
                        RestartWidget.restartApp(context);
                      });
                    }, () {
                      Navigator.pop(context);
                    });
                  });
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.setBool(SharedKeys.loginStatus, false);
              // await FirebaseAuth.instance.signOut().whenComplete(() {
              //   RestartWidget.restartApp(context);
              // });
            },
          ),
        ],
      ),
    );
  }

  Future<void> share() async {
    await Share.share(
        "Hey, Check out our app for notes syllabus and other features \n https://play.google.com/store/apps/details?id=com.inceptra.haiku");
  }
}
