import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/userModel.dart';

class UserProvider with ChangeNotifier {
  String _userId = "";
  UserModel _userModel = UserModel("mail", 0, false, "club");
  int _versionCode = 0;

  UserModel get userModel => _userModel;
  String get uuId => _userId;
  int get versionCode => _versionCode;

  Future fetchUserDetails() async {
    print(
        "++++++++++++++++++++++++++++++++++++User provider+++++++++++++++++++++++++++");
    try {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        _userId = await FirebaseAuth.instance.currentUser!.uid;
        final userRef =
            await FirebaseDatabase.instance.reference().child('users');
        await userRef.child(_userId).once().then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            final data = snapshot.value as Map<dynamic, dynamic>;
            _userModel = UserModel.fromJson(data);
            notifyListeners();
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchVersionCode() async {
    final reference =
        await FirebaseDatabase.instance.reference().child(FirebaseKeys.updates);

    await reference.child('code').once().then((DataSnapshot snapshot) {
      final data = snapshot.value;
      _versionCode = int.parse(data.toString());
    });
  }
}
