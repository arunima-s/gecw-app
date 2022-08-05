import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Models/ad-model.dart';
import 'package:gecwapp/Models/notificationModel.dart';

class AdsProvider with ChangeNotifier {
  List<ADModel> _ads = [];

  List<ADModel> get ads => _ads;

////////
//////
  // Verified Notifications
  Future getNotifications() async {
    print(
        "**************************************************************************************************************************************************************************************************************");
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object

    try {
      await databaseRef
          .child('ads')
          // .child(FirebaseKeys.verified)
          .once()
          .then((DataSnapshot snapshot) {
        final data = snapshot.value as List<dynamic>;

        _ads = data.map((e) => ADModel.fromJson(e)).toList();
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // deleteNotification(int index) {
  //   _notifications.removeAt(index);
  //   notifyListeners();
  // }
}
