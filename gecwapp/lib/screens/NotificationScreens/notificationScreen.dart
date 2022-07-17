import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:gecwapp/screens/NotificationScreens/addNotificationScreen.dart';
import 'package:gecwapp/screens/NotificationScreens/verifiy_norifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  List<NotificationModel> notificationsList = [];

  @override
  Widget build(BuildContext context) {
    print(
        '---------------------------------------Notification Screen--------------------------------------------------');

    notificationsList = context.watch<NotificationProvider>().notifications;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  /////////////
                  ////////////Verify button
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyNotificationScreen()));
                      },
                      icon: Icon(Icons.verified)),
                  ////////////
                  ///////////Add Button
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNotificationScreen(
                                notificationsList.length)));
                      },
                      icon: Icon(Icons.edit)),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                // color: AppColors.systemWhite,
                child: notificationsList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: context
                              .read<NotificationProvider>()
                              .getNotifications,
                          child: ListView.separated(
                            shrinkWrap: true,
                            // physics: ClampingScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 20);
                            },
                            itemCount: notificationsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: NotificationScreenItems(index, true),
                                onTap: () {
                                  openURL(notificationsList[index].link);
                                },
                              );
                            },
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }
}
