import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';

class TabBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .09,
      // width: 5,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        // borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      // color: Colors.blue,
      child: TabBar(
        labelColor: AppColors.systemWhite,
        unselectedLabelColor: AppColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        tabs: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.place), Text("Hostels")],
          ),
          // Tab(
          //   text: "Hostels",
          //   icon: Icon(Icons.place),
          // ),
          Tab(
            text: "Bus Timings",
            icon: Icon(Icons.bus_alert),
          ),
          Tab(
            text: "Calendar",
            icon: Icon(Icons.calendar_month),
          ),
          Tab(
              text: "Tools",
              icon: Icon(
                Icons.person_outline_rounded,
              ))
        ],
      ),
    );
  }
}
