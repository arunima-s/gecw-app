import 'package:flutter/material.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/customWidgets/customAppbar.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/navdrawer.dart';
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

    if (notificationsList.isEmpty) {
      context.read<UserProvider>().fetchUserDetails();
      context.read<NotificationProvider>().getNotifications();
    }
    return SafeArea(
      top: true,
      child: Scaffold(
        drawer: NavDrawer(),
        body: Column(
          children: [
            CustomAppBar(() {
              passedopenDrawerFunc(context);
            }),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      "Notifications",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      // Horizontal list view
                      padding: EdgeInsets.only(top: 10, left: 10),
                      height: screenHeight * 0.25,
                      // width: screenSizes[1] *,
                      child: _getRowList(context)),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: Text(
                      "Hostels",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: HomeScreenMenu(),
                  )
                ],
              ),
            ),
          ],
        ),
        // ),
      ),
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
                      : ImageBanner(
                          context
                              .watch<NotificationProvider>()
                              .notifications[index]
                              .image,
                          screenHeight * 0.3,
                          screenWidth * 0.8),
                  onTap: () => {
                    openURL(context
                        .watch<NotificationProvider>()
                        .notifications[index]
                        .link)
                  },
                );
              },
            ),
    );
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }

  void passedopenDrawerFunc(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
