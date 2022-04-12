import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/WebServices/hostelAPIManager.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

class HostelList extends StatefulWidget {
  HostelList({Key? key}) : super(key: key);
  final hostelAPIManager = HostelAPIManager();

  @override
  HostelListScreen createState() => HostelListScreen();
}

class HostelListScreen extends State<HostelList> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final hostels
    return Scaffold(
      body: Container(
        color: AppColors.white,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: ListView(
          // shrinkWrap: true,
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
            // Container(
            //     // Horizontal list view
            //     padding: EdgeInsets.only(top: 10),
            //     height: MediaQuery.of(context).size.height * 2,
            //     child: _getDummyList()),
          ],
        ),
      ),
    );
  }

  ///////////////////////
  //////////////////////////
  //////////////////////////
  //////////////////////////

  Widget _getMessageList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.hostelAPIManager.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = HostelListModel.fromJson(json);
          print(message);
          return HostelListItem(message.name, message.image);
        },
      ),
    );
  }

  Widget _getDummyList() {
    return Expanded(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HostelListItem("_hostelName", "https://picsum.photos/id/237/200/300"),
          HostelListItem("_hostelName", "https://picsum.photos/id/237/200/300"),
          HostelListItem("_hostelName", "https://picsum.photos/id/237/200/300"),
          HostelListItem("_hostelName", "https://picsum.photos/id/237/200/300"),
          HostelListItem("_hostelName", "https://picsum.photos/id/237/200/300")
        ],
      ),
    );
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
