import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/customWidgets/Alerts/loading-alert.dart';
import 'package:gecwapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
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
                        "Logout");
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
}
