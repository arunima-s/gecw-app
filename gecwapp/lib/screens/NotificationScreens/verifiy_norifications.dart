import 'package:flutter/material.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:provider/provider.dart';

class VerifyNotificationScreen extends StatelessWidget {
  List<NotificationModel> notificationsList = [];
  var refreshed = true;

  @override
  Widget build(BuildContext context) {
    notificationsList = context.watch<NotificationProvider>().notifications;
    final uhuhuhu = notificationsList.isEmpty && refreshed;
    if (refreshed) {
      context.read<NotificationProvider>().getNotifications();
      refreshed = false;
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
                onRefresh:
                    context.read<NotificationProvider>().getNotifications,
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: ClampingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20);
                  },
                  itemCount: notificationsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (!notificationsList[index].isVerified)
                        ? GestureDetector(
                            child: NotificationScreenItems(index, false),
                            onTap: () {
                              print("Tapped");
                            },
                          )
                        : SizedBox();
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
