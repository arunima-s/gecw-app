import 'package:flutter/material.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:provider/provider.dart';

class VerifyNotificationScreen extends StatelessWidget {
  List<NotificationModel> notificationsList = [];

  @override
  Widget build(BuildContext context) {
    notificationsList =
        context.watch<NotificationProvider>().unVerifiedNotifications;
    if (notificationsList.isEmpty) {
      context.read<NotificationProvider>().getUnVerifiedNotifications();
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(
            "Verify Notifications",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GWSpace(0.1, 0),
          Container(
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: context
                    .read<NotificationProvider>()
                    .getUnVerifiedNotifications,
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: ClampingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: notificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: NotificationScreenItems(index, false),
                      onTap: () {
                        //////////////
                        //////////////
                        ///
                        print("Tapped");
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
