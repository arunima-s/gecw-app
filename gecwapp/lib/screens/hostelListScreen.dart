import 'package:flutter/material.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';

class HostelListScreen extends StatelessWidget {
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
                          body: dummyHostelData.isEmpty
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
                     SafeArea(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Padding(
                             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                             child: Text("Hostels", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                           ),
                           Expanded(
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
                              ),
                           ),
                         ],
                       ),
                     )
    );
  }
}