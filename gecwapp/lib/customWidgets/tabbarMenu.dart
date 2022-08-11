import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/customWidgets/Alerts/exit-alert.dart';

class TabBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ExitAlert("alertMessage", "Do you want to exit?", "Exit");
            });
        return false;
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .09,
        // width: 5,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 5),
        decoration: BoxDecoration(
          // color: Colors.yellow,
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
            // Tab(
            //   text: "Calendar",
            //   icon: Icon(Icons.calendar_month),
            // ),
            Tab(
              text: "Haiku",
              icon: Icon(Icons.home),
            ),
            Tab(
                text: "Tools",
                icon: Icon(
                  Icons.person_outline_rounded,
                ))
          ],
        ),
      ),
    );
  }
}
