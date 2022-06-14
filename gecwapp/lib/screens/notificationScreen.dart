import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/hostelListItem.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';

class NotificationScreen extends StatelessWidget {

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notifications"),
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
              ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
              itemCount: dummyHostelData.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationScreenItems();
              },
            )
          ),
        ],
      ),
    );
  }
}