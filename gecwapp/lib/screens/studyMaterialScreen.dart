import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:gecwapp/screens/scholarshipScreen.dart';
import 'package:gecwapp/screens/semesterScreen.dart';

import 'HostelScreens/hostelListScreen.dart';

class HomeScreenMenu extends StatefulWidget {
  const HomeScreenMenu({Key? key}) : super(key: key);

  @override
  State<HomeScreenMenu> createState() => _HomeScreenMenuState();
}

class _HomeScreenMenuState extends State<HomeScreenMenu> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  var screenType = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HostelListScreen()))
                    },
                child: StudyMenuItem("assets/images/hostel.png", "Hostels")),
            StudyMenuItem("assets/images/bicycle.png", "Book Bicycle"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                // onTap: () => {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => StudyMaterialsScreen()))
                //     },
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => StudyMaterialsScreen(true));
                },
                child: StudyMenuItem("assets/images/syllabus.png", "Syllabus")),
            GestureDetector(
              child: StudyMenuItem(
                  "assets/images/scholarship.png", "Scholarships"),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScholarShipScreen()))
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => StudyMaterialsScreen(false));
                },
                child: StudyMenuItem("assets/images/notes.png", "Notes")),
            GestureDetector(
              child: StudyMenuItem("assets/images/notes.png", "Notes"),
              onTap: () {
                showNotification();
              },
            ),
          ],
        )
      ],
    );
  }

  // Future _showNotificationWithDefaultSound() async {
  //   print('///////////////////////////////////');
  //   var flutterLocalNotificationsPlugin;
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'your channel id', 'your channel name',
  //       importance: Importance.max, priority: Priority.high);
  //   // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails();
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'New Post',
  //     'How to Show Notification in Flutter',
  //     platformChannelSpecifics,
  //     payload: 'Default_Sound',
  //   );
  // }

  Future showNotification() async {
    var android = new AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'New Video is out', 'Flutter Local Notification', platform,
        payload: 'Nitish Kumar Singh is part time Youtuber');
  }
}

// class StudyMaterialsScreen extends StatelessWidget {
//   // const StudyMaterialsScreen({ Key? key }) : super(key: key);

// }

class StudyMenuItem extends StatelessWidget {
  final String _assetPath, text;
  StudyMenuItem(this._assetPath, this.text);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
      height: MediaQuery.of(context).size.width * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.systemWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey3,
                offset: Offset(2.0, 2.0),
                spreadRadius: 3.0,
                blurRadius: 2.0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _assetPath,
            height: MediaQuery.of(context).size.width * 0.25,
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          GWSpace(screenHeight * 0.01, 0),
          Text(text)
        ],
      ),
    );
  }
}
