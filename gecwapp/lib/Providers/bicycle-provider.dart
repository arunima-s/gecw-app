import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/bicycle-model.dart';
import 'package:gecwapp/Models/notificationModel.dart';

class BicycleProvider with ChangeNotifier {
  List<BicycleClubModel> _bicycles = [];
  List<BicycleClubModel> get bicycles => _bicycles;

  Future getBicycleList() async {
    print(
        "**************************************************************************************************************************************************************************************************************");
    final databaseRef =
        await FirebaseDatabase.instance.reference(); //database reference object

    try {
      await databaseRef
          .child(FirebaseKeys.bicycle)
          .once()
          .then((DataSnapshot snapshot) {
        final data = snapshot.value as List<dynamic>;
        // print(data);
        // _bicycles =
        //     data.values.map((e) => BicycleClubModel.fromJson(e)).toList();
        _bicycles = data.map((e) => BicycleClubModel.fromJson(e)).toList();
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
