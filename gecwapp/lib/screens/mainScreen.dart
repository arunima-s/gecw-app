import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/sharedPrefs_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/customWidgets/Alerts/alert_dialog.dart';
import 'package:gecwapp/customWidgets/customAppbar.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/navdrawer.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:gecwapp/screens/NotificationScreens/notification-detail-screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  var hostelData = [];
  List<NotificationModel> notificationsList = [];
  double screenHeight = 0, screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    print('------------Main Screen------------------');
    notificationsList = context.watch<NotificationProvider>().notifications;
    screenHeight = context.watch<GWValuesProvider>().height;
    screenWidth = context.watch<GWValuesProvider>().width;
    final userName = context.watch<SharedPrefsProvider>().userName;
    final versionCode = context.watch<UserProvider>().versionCode;
    checkForUpdates(context, versionCode);

    if (notificationsList.isEmpty) {
      context.read<UserProvider>().fetchUserDetails();
      context.read<NotificationProvider>().getNotifications();
    }
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      drawer: NavDrawer(),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.3,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.systemWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: screenHeight * 0.7,
              width: screenWidth * 0.9,
            ),
          ),
          Column(
            children: [
              CustomAppBar(() {
                passedopenDrawerFunc(context);
              }),
              Row(
                children: [
                  GWSpace(0, screenWidth * 0.2),
                  AutoSizeText(
                    userName,
                    style:
                        TextStyle(color: AppColors.systemWhite, fontSize: 25),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //   child: Text(
                    //     "Notifications",
                    //     style:
                    //         TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    Container(
                        // Horizontal list view
                        padding: EdgeInsets.only(top: 10),
                        height: screenWidth * 0.5,
                        // width: screenSizes[1] *,
                        child: _getRowList(context)),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30, left: 10),
                    //   child: Text(
                    //     "Hostels",
                    //     style:
                    //         TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: HomeScreenMenu(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }

  Widget _getRowList(BuildContext context) {
    return Container(
      child: notificationsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: notificationsList.isEmpty ||
                          !notificationsList[index].isVerified
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ImageBanner(
                              context
                                  .watch<NotificationProvider>()
                                  .notifications[index]
                                  .image,
                              screenHeight * 0.3,
                              screenWidth * 0.8),
                        ),
                  onTap: () {
                    // openURL(context
                    //     .watch<NotificationProvider>()
                    //     .notifications[index]
                    //     .link);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotificationDetailsScreen(index)));
                  },
                );
              },
            ),
    );
  }

  /////
  /////Check version
  Future checkForUpdates(BuildContext context, int remoteCode) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    if (int.parse(code) < remoteCode) {
      showDialog(
          // barrierDismissible: false,
          context: context,
          builder: (BuildContext buildContext) {
            return WillPopScope(
                onWillPop: () => Future.value(false),
                child: AlertScreen(
                    "You have to update to use all the functionalities",
                    "App OutDated",
                    "Update", () {
                  openURL(
                      "https://play.google.com/store/apps/details?id=com.inceptra.haiku");
                }, () {
                  SystemNavigator.pop();
                }));
            //
            //
          });
    }
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }

  void passedopenDrawerFunc(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
