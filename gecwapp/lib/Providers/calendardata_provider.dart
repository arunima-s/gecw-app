import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/calendar_datamodel.dart';
import 'package:gecwapp/Models/notificationModel.dart';

class CalendarDataProvider with ChangeNotifier {
  List<CalendarDataModel> _notifications = [];

  List<CalendarDataModel> get notifications => _notifications;

  // Fetch notifications
  Future getNotifications() async {
    print(
        "*********************************************************Calendar Provider*****************************************************************************************************************************************************");
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.calendar)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      _notifications =
          data.values.map((e) => CalendarDataModel.fromJson(e)).toList();
      notifyListeners();
    });
  }

  deleteNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }
}
