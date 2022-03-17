import 'package:flutter/material.dart';
import 'package:gecwapp/customWidgets/hostelListItem.dart';

class HoselListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostels"),
      ),
      body: ListView(
        children: [HostelListItem("Mada", "assets/images/room1.jpeg")],
      ),
    );
  }
}
