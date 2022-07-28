import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/bicycle-model.dart';
import 'package:gecwapp/Models/userModel.dart';
import 'package:gecwapp/Providers/users_provider.dart';
import 'package:provider/provider.dart';

class BicycleClubDetailsScreen extends StatelessWidget {
  final int index;
  BicycleClubDetailsScreen(this.index);
  UserModel? _userModel;

  @override
  Widget build(BuildContext context) {
    _userModel = context.watch<UserProvider>().userModel;

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  bookCycle();
                },
                child: Text("Book"))
          ],
        ),
      )),
    );
  }

  Future bookCycle() async {
    final databseRef =
        await FirebaseDatabase.instance.reference().child(FirebaseKeys.bicycle);
    final bicycleModel = BicycleClubModel(_userModel!.mail, "location", false);
    databseRef.child(index.toString()).set(bicycleModel.toJson());
  }
}
