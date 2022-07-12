import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Models/userModel.dart';

class UserProvider with ChangeNotifier {
  String _userId = "";
  UserModel? _userModel;

  UserModel get userModel => _userModel!;
  String get uuId => _userId;

  Future fetchUserDetails() async {
    print(
        "++++++++++++++++++++++++++++++++++++User provider+++++++++++++++++++++++++++");
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      _userId = await FirebaseAuth.instance.currentUser!.uid;
      final userRef =
          await FirebaseDatabase.instance.reference().child('users');
      await userRef.child(_userId).once().then((DataSnapshot snapshot) {
        if (snapshot.value == null) {
          final data = snapshot.value as Map<dynamic, dynamic>;
          _userModel = UserModel.fromJson(data);
          notifyListeners();
        }
      });
    }
  }
}
