import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/hostelListItem.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/WebServices/hostelAPIManager.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

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
    HostelListModel("1", "name", "assets/images/room2.jpeg",
        "https://goo.gl/maps/sWPNYHsvxx8G9KGH9"),
    HostelListModel("1", "name", "assets/images/room2.jpeg",
        "https://goo.gl/maps/sWPNYHsvxx8G9KGH9"),
    HostelListModel("1", "name", "assets/images/room2.jpeg",
        "https://goo.gl/maps/sWPNYHsvxx8G9KGH9"),
    HostelListModel("1", "name", "assets/images/room2.jpeg",
        "https://goo.gl/maps/sWPNYHsvxx8G9KGH9")
  ];

  @override
  void initState() {
    // TODO: implement initState
    getDummyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _getMessageList();
    // final hostels
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "WELCOME",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.notifications)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Notifications",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                // Horizontal list view
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.25,
                child: _getRowList()),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "Hostels",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
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
                child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemCount: dummyHostelData.length,
              itemBuilder: (BuildContext context, int index) {
                return HostelListItem(dummyHostelData[index]);
              },
            ))
          ],
        ),
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
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, position) {
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: Image.asset('assets/images/room1.jpeg'),
                ),
              );
            }));
  }
}
