import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:provider/provider.dart';

class NotificationScreenItems extends StatelessWidget {
  NotificationModel? notificationItem;
  final int index;
  final bool isVerified;
  NotificationScreenItems(this.index, this.isVerified);
  @override
  Widget build(BuildContext context) {
    notificationItem = isVerified
        ? context.watch<NotificationProvider>().notifications[index]
        : context.watch<NotificationProvider>().unVerifiedNotifications[index];
    final userId = context.watch<UserProvider>().uuId;
    return Container(
      // width: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.systemWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey3,
                offset: Offset(2.0, 2.0),
                spreadRadius: 3.0,
                blurRadius: 2.0)
          ]),
      // margin: EdgeInsets.only(top: 10),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBanner(
              notificationItem!.image, MediaQuery.of(context).size.width * 0.5),
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width * 0.3,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notificationItem!.eventDate),
                Text(notificationItem!.name),
                Text(
                  notificationItem!.details,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          ),
          userId == notificationItem!.userId
              ? Expanded(
                  child: IconButton(
                    // iconSize: 0.1,
                    onPressed: () {
                      deleteNotification(context);
                    },
                    icon: Icon(Icons.delete),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  deleteNotification(BuildContext context) async {
    //////
    //////Notification Delete
    ///
    DatabaseReference notificationRef;
    if (isVerified) {
      context.read<NotificationProvider>().deleteNotification(index);
      notificationRef = await FirebaseDatabase.instance
          .reference()
          .child(FirebaseKeys.notifications)
          .child(FirebaseKeys.verified);
      //////
      //////Calendar Delete
      context.read<CalendarDataProvider>().deleteNotification(index);

      final calendarRef = await FirebaseDatabase.instance
          .reference()
          .child(FirebaseKeys.calendar);
      await calendarRef.child(notificationItem!.timeStamp).remove();
    } else {
      context.read<NotificationProvider>().deleteUnVerifiedNotification(index);
      await FirebaseDatabase.instance
          .reference()
          .child(FirebaseKeys.notifications)
          .child(FirebaseKeys.unverified);
    }

    final storageRef =
        await FirebaseStorage.instance.refFromURL(notificationItem!.image);
    storageRef.delete();
  }
}
