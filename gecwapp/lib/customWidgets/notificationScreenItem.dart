import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Constants/values.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/calendardata_provider.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:provider/provider.dart';

class NotificationScreenItems extends StatelessWidget {
  NotificationModel? notificationItem;
  final int index;
  final bool isVerified;
  NotificationScreenItems(this.index, this.isVerified);
  UserModel? userData;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    userData = context.watch<UserProvider>().userModel;
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
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      // child: Row(
      //   // mainAxisAlignment: MainAxisAlignment.,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     ImageBanner(
      //         notificationItem!.image, MediaQuery.of(context).size.width * 0.5),
      //     Container(
      //       // color: Colors.red,
      //       width: MediaQuery.of(context).size.width * 0.3,
      //       margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(notificationItem!.eventDate),
      //           Text(notificationItem!.name),
      //           Text(
      //             notificationItem!.details,
      //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      //           ),
      //         ],
      //       ),
      //     ),
      //     userId == notificationItem!.userId
      //         ? Expanded(
      //             child: IconButton(
      //               // iconSize: 0.1,
      //               onPressed: () {
      //                 deleteNotification(context);
      //               },
      //               icon: Icon(Icons.delete),
      //             ),
      //           )
      //         : SizedBox(),
      //   ],
      // ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 14,
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(notificationItem!.image), //NetworkImage
                    radius: 12,
                  ), //CircleAvatar
                ), //CircleAvatar
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationItem!.user,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text("Evenet Date")
                ],
              ),
            ),
            (userId == notificationItem?.userId)
                ? GWSpace(0, screenWidth * 0.4)
                : GWSpace(0, screenWidth * 0.47),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    deleteNotification(context);
                    print("Delete");
                  } else {
                    approveNotifcation(context);
                    print("Approve");
                  }
                },
                child: (userId == notificationItem?.userId)
                    ? Center(child: Icon(Icons.menu))
                    : SizedBox(),
                itemBuilder: (context) {
                  if (userData?.access == 2) {
                    return [
                      PopupMenuItem(value: 1, child: Text("Delete")),
                      PopupMenuItem(value: 2, child: Text("Approve"))
                    ];
                  } else {
                    return [PopupMenuItem(value: 1, child: Text("Delete"))];
                  }
                },
              ),
            ),
            IconButton(
                onPressed: null,
                icon: Icon(Icons.notifications_active_outlined))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageBanner(
                notificationItem!.image, screenHeight * 0.3, screenWidth * 0.9),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(notificationItem!.details),
        )
      ]),
    );
  }

  deleteNotification(BuildContext context) async {
    //////
    //////Notification Delete
    ///
    DatabaseReference notificationRef;

    context.read<NotificationProvider>().deleteNotification(index);
    notificationRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.notifications);
    await notificationRef.child(notificationItem!.timeStamp).remove();
    // context.read<CalendarDataProvider>().deleteNotification(index);

    //////
    //////Calendar Delete

    final calendarRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.calendar);
    await calendarRef.child(notificationItem!.timeStamp).remove();

    //////
    /////Delete image
    try {
      final storageRef =
          await FirebaseStorage.instance.refFromURL(notificationItem!.image);
      storageRef.delete();
    } catch (e) {
      print("---------Storage deletion error---------$e");
    }
  }

  /////////////
  //////////
  //////////Approve notification
  Future approveNotifcation(BuildContext context) async {
    final notificationRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.notifications);

    final notItem = NotificationModel(
        notificationItem!.image,
        true,
        notificationItem!.link,
        notificationItem!.details,
        notificationItem!.userId,
        notificationItem!.timeStamp,
        notificationItem!.eventDate,
        notificationItem!.user);
    notificationRef.child(notificationItem!.timeStamp).set(notItem.toJson());
    context.read<NotificationProvider>().getNotifications();
  }

  ///////////
  //////////
  //////Toggle notification alert
  void toggleNotificationAlert() {}
}
