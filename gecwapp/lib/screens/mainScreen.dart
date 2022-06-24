import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/CustomWidgets/customAppbar.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Managers/hostelAPIManager.dart';

import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/Screens/studyMaterialScreen.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  var hostelData = [];
  List<NotificationModel> notificationsList = [];
  @override
  Widget build(BuildContext context) {
    print('------------Main Screen------------------');
    notificationsList = context.watch<NotificationProvider>().notifications;
    context.read<UserProvider>().fetchUserDetails;
    // context.read<NotificationProvider>().getNotifications;
    if (notificationsList.isEmpty) {
      context.read<NotificationProvider>().getNotifications();
    }
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(),
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
                      height: MediaQuery.of(context).size.height * 0.25,
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
      // child: Expanded(
      child: notificationsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // separatorBuilder: (BuildContext context, int index) {
              //   return SizedBox(height: 20);
              // },
              // physics: NeverScrollableScrollPhysics(), ///
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                // return HostelListItem(dummyHostelData[index]);
                return GestureDetector(
                  // child: Image.network(notificationsList[index].image, fit: BoxFit.cover,),
                  child: notificationsList.isEmpty
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.red,
                        )
                      : ImageBanner(
                          context
                              .watch<NotificationProvider>()
                              .notifications[index]
                              .image,
                          MediaQuery.of(context).size.width * 0.6),

                  onTap: () => {
                    openURL(context
                        .watch<NotificationProvider>()
                        .notifications[index]
                        .link)
                  },
                );
              },
            ),
      // ),
    );
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}
