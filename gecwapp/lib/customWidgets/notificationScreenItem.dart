import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/calendar_datamodel.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/customWidgets/simple_widgets.dart';
import 'package:gecwapp/screens/NotificationScreens/notification-detail-screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationScreenItems extends StatelessWidget {
  NotificationModel? notificationItem;
  final int index;
  final bool isVerified;
  NotificationScreenItems(this.index, this.isVerified);
  UserModel? userData;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    userData = context.watch<UserProvider>().userModel;
    notificationItem =
        context.watch<NotificationProvider>().notifications[index];
    final userId = context.watch<UserProvider>().uuId;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(index)));
      },
      child: Container(
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
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 11,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(notificationItem!.image), //NetworkImage
                      radius: 10,
                    ), //CircleAvatar
                  ), //CircleAvatar
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationItem!.user,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    // Text("Evenet Date")
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.2,
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
                    }
                    // else {
                    //   approveNotifcation(context);
                    //   print("Approve");
                    // }
                  },
                  child: (userId == notificationItem?.userId)
                      ? Center(child: Icon(Icons.menu))
                      : SizedBox(),
                  itemBuilder: (context) {
                    if (userData?.access == 2) {
                      return [
                        PopupMenuItem(value: 1, child: Text("Delete")),
                        // PopupMenuItem(value: 2, child: Text("Approve"))
                      ];
                    } else {
                      return [PopupMenuItem(value: 1, child: Text("Delete"))];
                    }
                  },
                ),
              ),
              // IconButton(
              //     onPressed: null,
              //     icon: Icon(Icons.notifications_active_outlined))
              SizedBox(
                height: screenHeight * 0.055,
              )
            ],
          ),
          ImageBanner(
              notificationItem!.image, screenHeight * 0.3, screenWidth * 0.9),
          SizedBox(
            height: screenHeight * 0.01,
          )
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(notificationItem!.details),
          // )
        ]),
      ),
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
    setCalendarEvent();
    // scheduleNotifications();
    context.read<NotificationProvider>().getNotifications();
  }

  Future setCalendarEvent() async {
    final calendarRef = await FirebaseDatabase.instance
        .reference()
        .child(FirebaseKeys.calendar);

    final calendarModel = CalendarDataModel(notificationItem!.user,
        notificationItem!.eventDate, notificationItem!.details);

    await calendarRef
        .child(notificationItem!.timeStamp)
        .set(calendarModel.toJson())
        .whenComplete(() {
      scheduleNotifications(calendarModel);
    });
  }

  Future<void> scheduleNotifications(CalendarDataModel calendar) async {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(calendar.date);
    print(tempDate);
    // DateTime(int year, [int month = 1, int day = 1,
    // int hour = 0, int minute = 0, int second = 0,
    // int millisecond = 0, int microsecond = 0])
    final time = tempDate.subtract(Duration(days: 1));
    final notificationTime = new DateTime(time.year, time.month, time.day, 16,
        36, time.second, time.millisecond, time.microsecond);
    String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(notificationTime);

    tz.initializeTimeZones(); //  <----
    var android = new AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        tz.TZDateTime.from(notificationTime, tz.local),
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //   Future setLocalNotification() async {
  //   var android = new AndroidNotificationDetails('channel id', 'channel NAME',
  //       priority: Priority.high, importance: Importance.max);
  //   var iOS = new IOSNotificationDetails();
  //   var platform = new NotificationDetails(android: android, iOS: iOS);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'New Video is out', 'Flutter Local Notification', platform,
  //       payload: 'Nitish Kumar Singh is part time Youtuber');
  // }

  ///////////
  //////////
  //////Toggle notification alert
  void toggleNotificationAlert() {}
}
