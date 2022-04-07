import 'package:flutter/material.dart';

class TabBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Hostels",
            icon: Icon(Icons.place),
          ),
          Tab(
            text: "Bus Timings",
            icon: Icon(Icons.bus_alert),
          ),
          Tab(
            text: "Verenthelm",
            icon: Icon(Icons.person),
          )
        ],
      ),
    );
  }
}
