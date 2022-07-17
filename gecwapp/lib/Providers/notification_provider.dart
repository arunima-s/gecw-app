import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> _unVerifiedNotifications = [];

  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get unVerifiedNotifications =>
      _unVerifiedNotifications;

////////
//////
  // Verified Notifications
  Future getNotifications() async {
    print(
        "**************************************************************************************************************************************************************************************************************");
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.notifications)
        .child(FirebaseKeys.verified)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      _notifications =
          data.values.map((e) => NotificationModel.fromJson(e)).toList();
      notifyListeners();
    });
  }

  deleteNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }

  /////
  ///////////Unverified

  Future getUnVerifiedNotifications() async {
    print(
        "**************************************************************************************************************************************************************************************************************");
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.notifications)
        .child(FirebaseKeys.unverified)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      _unVerifiedNotifications =
          data.values.map((e) => NotificationModel.fromJson(e)).toList();
      notifyListeners();
    });
  }

  deleteUnVerifiedNotification(int index) {
    _unVerifiedNotifications.removeAt(index);
    notifyListeners();
  }
}
