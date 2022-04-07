import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text("Hostels"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [_getMessageList()],
        ),
      ),
      // body: _getMessageList(),
      // body: ListView(
      //   children: [
      //     HostelListItem("Mada", "assets/images/room1.jpeg"),
      //     HostelListItem("Dharavi", "assets/images/room2.jpeg")
      //   ],
      // ),
    );
  }

  Widget _getMessageList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.hostelAPIManager.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = HostelListModel.fromJson(json);
          print("---------------------------");
          print(message);
          return HostelListItem(message.name, message.image);
          // return MessageWidget(message.text, message.date);
        },
      ),
    );
  }
}

// class MessageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
