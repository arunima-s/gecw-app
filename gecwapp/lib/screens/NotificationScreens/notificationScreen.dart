import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:gecwapp/screens/NotificationScreens/addNotificationScreen.dart';
import 'package:gecwapp/screens/NotificationScreens/verifiy_norifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  List<NotificationModel> notificationsList = [];
  UserModel? userData;
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    print(
        '---------------------------------------Notification Screen--------------------------------------------------');
    userData = context.watch<UserProvider>().userModel;
    notificationsList = context.watch<NotificationProvider>().notifications;
    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /////
                  //////Back Button
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  AutoSizeText(
                    "Notifications",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: screenWidth * 0.25,
                  ),
                  /////////////
                  ////////////Verify button
                  (userData!.access == 2)
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VerifyNotificationScreen()));
                          },
                          icon: Icon(Icons.verified))
                      : SizedBox(),
                  ////////////
                  ///////////Add Button
                  (userData!.access == 1 || userData!.access == 2)
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddNotificationScreen(
                                    notificationsList.length)));
                          },
                          icon: Icon(Icons.edit))
                      : SizedBox(),
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
                              return (notificationsList[index].isVerified)
                                  ? GestureDetector(
                                      child:
                                          NotificationScreenItems(index, false),
                                      onTap: () {
                                        print("Tapped");
                                      },
                                    )
                                  : SizedBox();

                              // return GestureDetector(
                              //   child: NotificationScreenItems(index, true),
                              //   onTap: () {
                              //     openURL(notificationsList[index].link);
                              //   },
                              // );
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
