import 'package:flutter/material.dart';
import 'package:gecwapp/CustomWidgets/navdrawer.dart';
import 'package:gecwapp/CustomWidgets/tabbarMenu.dart';
import 'package:gecwapp/Screens/busTimings.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/screens/mainScreen.dart';

import 'calendarScreen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: NavDrawer(),
          // appBar: CustomAppBar(),
          bottomNavigationBar: TabBarMenu(),
          // bottomNavigationBar: Container(
          //   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //   color: Colors.red,
          //   height: 50,
          //   // width: 5,
          // ),
          body: TabBarView(children: [
            MainScreen(),
            // HostelList(),
            // WebScraperApp(),
            BusTiming(),
            CalendarScreen(),
            HomeScreenMenu()
          ]),
        ),
      ),
    );
  }
}


// class HomePage extends StatelessWidget {
//   // const HomePage({ Key? key }) : super(key: key);
// // 
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(),      
//     );
//   }
// }