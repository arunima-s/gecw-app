import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/Providers/notification_provider.dart';
import 'package:gecwapp/customWidgets/notificationScreenItem.dart';
import 'package:gecwapp/screens/addNotificationScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  // const NotificationScreen({Key? key}) : super(key: key);
  // final List<NotificationModel> notificationList;
  // NotificationScreen(this.notificationList);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> notificationsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<NotificationProvider>().notifications.isEmpty) {
        context.read<NotificationProvider>().getNotifications();
      }
    });
    // getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    print('------------Notification Screen------------------');
    // context.read<NotificationProvider>().getNotifications;
    notificationsList = context.watch<NotificationProvider>().notifications;
    // notificationsList = context.watch<NotificationProvider>().notifications;
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
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNotificationScreen(
                                notificationsList.length)));
                      },
                      icon: Icon(Icons.edit))
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
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: notificationsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: NotificationScreenItems(
                                  notificationsList[index]),
                              onTap: () {
                                openURL(notificationsList[index].link);
                              },
                            );
                          },
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  // Fetch notifications
  Future<void> getNotifications() async {
    final databaseRef =
        FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.notifications)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final notifications =
          data.values.map((e) => NotificationModel.fromJson(e)).toList();
      if (this.mounted) {
        setState(() {
          notificationsList = List.from(notifications.reversed);
        });
      }
    });
  }

  Future<void> openURL(String _url) async {
    await launch(_url,
        forceSafariVC: true, forceWebView: true, enableJavaScript: true);
  }

  editHostel() {}
}
