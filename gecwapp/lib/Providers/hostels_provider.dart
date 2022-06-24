import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/hostelListModel.dart';

class HostelProvider with ChangeNotifier {
  List<HostelListModel> _hostels = [];

  List<HostelListModel> get hostels => _hostels;

  Future fetchUserDetails() async {
    print('*****************Hostel Provider****************');
    final databaseRef =
        FirebaseDatabase.instance.reference(); //database reference object
    await databaseRef
        .child(FirebaseKeys.hostels)
        .once()
        .then((DataSnapshot snapshot) {
      final data = snapshot.value as List<dynamic>;
      // print(data);
      _hostels = data.map((e) => HostelListModel.fromJson(e)).toList();
      notifyListeners();
      // setState(() {
      //   hostelData = hostels;
      //   // hostelData = message;
      // });
      // snapshot.value
    });
  }
}
