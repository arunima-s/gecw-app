import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/hostelListItem.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  // const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
    List<NotificationModel> notificationsList = [];

    var dummyHostelData = [
    HostelListModel(
        "1",
        "name",
        "assets/images/room2.jpeg",
        "https://goo.gl/maps/1uRL72EP91LrVsR26",
        "9074746225",
        "₹1250",
        "For boys | With Food | 9 Beds"),
    HostelListModel(
        "2",
        "name",
        "assets/images/room2.jpeg",
        "https://goo.gl/maps/1uRL72EP91LrVsR26",
        "9074746225",
        "₹1250",
        "For boys | With Food | 9 Beds"),
    HostelListModel(
        "3",
        "name",
        "assets/images/room2.jpeg",
        "https://goo.gl/maps/1uRL72EP91LrVsR26",
        "9074746225",
        "₹1250",
        "For boys | With Food | 9 Beds"),
    HostelListModel(
        "4",
        "name",
        "assets/images/room2.jpeg",
        "https://goo.gl/maps/1uRL72EP91LrVsR26",
        "9074746225",
        "₹1250",
        "For boys | With Food | 9 Beds")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Text("Notifications", style: TextStyle(fontSize: 25,),),
            ),
            SizedBox(height: 25,),
            Container(
              // color: AppColors.systemWhite,
              child: dummyHostelData.isEmpty
              ? CircularProgressIndicator()
              : 
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: ClampingScrollPhysics(),
              //     itemCount: hostelData.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return HostelListItem(hostelData[index]);
              //     },
              //   ),
              // child:
                Expanded(
                  child: ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: notificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(child: NotificationScreenItems(notificationsList[index]),
                    onTap: () {
                      openURL(notificationsList[index].link);
                    },
                    );
                  },
                            ),
                )
            ),
          ],
        ),
      ),
    );
  }


    // Fetch notifications
    Future<void> getNotifications() async {
    final databaseRef = FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef.child('notifications').once().then((DataSnapshot snapshot) {
      final data = snapshot.value as List<dynamic>;
      print(data);
      final notifications = data.map((e) => NotificationModel.fromJson(e)).toList();
      setState(() {
        notificationsList = notifications;
      });
    });
  }

    Future<void> openURL(String _url) async {
    await launch(_url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
}