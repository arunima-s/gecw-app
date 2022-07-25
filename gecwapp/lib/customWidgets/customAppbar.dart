import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/screens/NotificationScreens/notificationScreen.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final Function openDrawer;
  CustomAppBar(this.openDrawer);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // _key.currentState?.openDrawer();
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            // child: Text(
            //   "WELCOME",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            // ),
            child: AutoSizeText(
              "WELCOME",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
              },
              icon: Icon(
                Icons.notifications,
                size: 30,
              ))
        ],
      ),
    );
  }
}
