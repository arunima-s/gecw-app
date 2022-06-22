import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/customAppbar.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Managers/hostelAPIManager.dart';

import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);
  final hostelAPIManager = HostelAPIManager();
  @override
  MainScreen createState() => MainScreen();
}

class MainScreen extends State<Main> {
  ScrollController _scrollController = ScrollController();
  var hostelData = [];
  List<NotificationModel> notificationsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDummyList();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    // _getMessageList();
    // final hostels
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "Notifications",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      // Horizontal list view
                      padding: EdgeInsets.only(top: 10, left: 10),
                      height: MediaQuery.of(context).size.height * 0.25,
                      // width: MediaQuery.of(context).size.height * 0.5,
                      // width: 500,
                      child: _getRowList()),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: Text(
                      "Hostels",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    // child: hostelData.isEmpty
                    // ? CircularProgressIndicator()
                    // : ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: hostelData.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return HostelListItem(hostelData[index]);
                    //     },
                    //   ),
                    // child: ListView.separated(
                    //   shrinkWrap: true,
                    //   physics: ClampingScrollPhysics(),
                    //   separatorBuilder: (BuildContext context, int index) {
                    //     return SizedBox(height: 20);
                    //   },
                    //   itemCount: dummyHostelData.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return HostelListItem(dummyHostelData[index]);
                    //   },
                    // )
                    child: HomeScreenMenu(),
                  )
                ],
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  // List<HostelListModel> getDummyList() {
  Future<void> getDummyList() async {
    print("myr");
    final databaseRef =
        FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef.child('messages').once().then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      final json = snapshot.value as List<dynamic>;
      final message = json.map((e) => HostelListModel.fromJson(e)).toList();
      // print(message);
      setState(() {
        hostelData = message;
      });
      // snapshot.value
    });
  }

  // Fetch notifications
  Future<void> getNotifications() async {
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.notifications)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      // final data = snapshot.value;
      print(data);
      final notifications =
          data.values.map((e) => NotificationModel.fromJson(e)).toList();
      setState(() {
        notificationsList = notifications;
        // hostelData = message;
      });
      // snapshot.value
    });
  }

  Widget _getRowList() {
    return Container(
      // child: Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // separatorBuilder: (BuildContext context, int index) {
        //   return SizedBox(height: 20);
        // },
        // physics: NeverScrollableScrollPhysics(), ///
        itemCount: notificationsList.length,
        itemBuilder: (BuildContext context, int index) {
          // return HostelListItem(dummyHostelData[index]);
          return GestureDetector(
            // child: Image.network(notificationsList[index].image, fit: BoxFit.cover,),
            child: notificationsList.isEmpty
                ? CircularProgressIndicator()
                : ImageBanner(notificationsList[index].image,
                    MediaQuery.of(context).size.width * 0.6),

            onTap: () => {openURL(notificationsList[index].link)},
          );
        },
      ),
      // ),
    );
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}
