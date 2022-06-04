import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/customAppbar.dart';
import 'package:gecwapp/CustomWidgets/hostelListItem.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Managers/hostelAPIManager.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';

class HostelList extends StatefulWidget {
  HostelList({Key? key}) : super(key: key);
  final hostelAPIManager = HostelAPIManager();
  @override
  HostelListScreen createState() => HostelListScreen();
}

class HostelListScreen extends State<HostelList> {
  ScrollController _scrollController = ScrollController();
  var hostelData = [];

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
    // getDummyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _getMessageList();
    // final hostels
    return SafeArea(
      top: true,
      child: Scaffold(
        body:
            //  Container(
            //   color: Colors.white,
            //   padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            //   child:
            Column(
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.1,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Icon(Icons.menu),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 20),
            //         child: Text(
            //           "WELCOME",
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            //         ),
            //       ),
            //       Spacer(),
            //       Icon(Icons.notifications)
            //     ],
            //   ),
            // ),
            CustomAppBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.1,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Icon(Icons.menu),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 20),
                  //         child: Text(
                  //           "WELCOME",
                  //           style:
                  //               TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  //         ),
                  //       ),
                  //       Spacer(),
                  //       Icon(Icons.notifications)
                  //     ],
                  //   ),
                  // ),
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

  Future<String> getData() {
    return Future.delayed(Duration(seconds: 2), () {
      return "I am data";
      // throw Exception("Custom Error");
    });
  }

  Widget _getRowList() {
    return Container(
        // width: MediaQuery.of(context).size.width * 0.8,
        width: 10,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, position) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: Image.asset(
                    'assets/images/room1.jpeg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              );
            }));
  }
}
