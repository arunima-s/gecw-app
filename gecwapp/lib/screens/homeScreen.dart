import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/values.dart';
import 'package:gecwapp/CustomWidgets/navdrawer.dart';
import 'package:gecwapp/CustomWidgets/tabbarMenu.dart';
import 'package:gecwapp/Providers/custom-ads-provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/busTimings.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/screens/Tools/tools-screen.dart';
import 'package:gecwapp/screens/mainScreen.dart';
import 'package:provider/provider.dart';

import 'calendarScreen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    context.read<GWValuesProvider>().setScreenSize(screenHeight, screenWidth);
    context.read<SharedPrefsProvider>().fetchSharedPrefs();
    context.read<UserProvider>().fetchVersionCode();
    context.read<AdsProvider>().getNotifications();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          // backgroundColor: Colors.red,
          drawer: NavDrawer(),
          // appBar: CustomAppBar(),
          bottomNavigationBar: TabBarMenu(),

          body: TabBarView(children: [
            // HostelList(),
            // WebScraperApp(),
            // BusTiming(),
            // CalendarScreen(),
            MainScreen(),

            ToolSScreen()
          ]),
        ),
      ),
    );
  }
}
