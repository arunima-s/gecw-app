import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:provider/provider.dart';

class NotificationScreenItems extends StatelessWidget {
  NotificationModel? notificationItem;
  final int index;
  NotificationScreenItems(this.index);
  @override
  Widget build(BuildContext context) {
    notificationItem =
        context.watch<NotificationProvider>().notifications[index];
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
            child: Text(
              notificationItem!.details,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
    final notificationRef = await FirebaseDatabase.instance.reference();
    final storageRef =
        await FirebaseStorage.instance.refFromURL(notificationItem!.image);
    storageRef.delete();
    context.read<NotificationProvider>().deleteNotification(index);
    await notificationRef
        .child(FirebaseKeys.notifications)
        .child(notificationItem!.timeStamp)
        .remove();
    // print(notificationItem);
  }
}
