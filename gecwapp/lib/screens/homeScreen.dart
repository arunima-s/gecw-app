import 'package:flutter/material.dart';
import 'package:gecwapp/CustomWidgets/tabbarMenu.dart';
import 'package:gecwapp/Screens/busTimings.dart';
import 'package:gecwapp/Screens/hostelListScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBarMenu(),
          body: TabBarView(children: [
            HostelList(),
            // HostelList(),
            // WebScraperApp(),
            BusTiming(),
            Container(
              child: Icon(Icons.home),
            )
          ]),
        ),
      ),
    );
  }
}
