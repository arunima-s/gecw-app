import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/roomModel.dart';
import 'package:gecwapp/customWidgets/rounded_button.dart';
import 'package:gecwapp/screens/Bingo-Screens/bingo-alert.dart';
import 'package:gecwapp/screens/Bingo-Screens/bingo-main.dart';

class BingoLobby extends StatelessWidget {
  const BingoLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          RoundedButton("CREATE", () {
            createRoom(context, "uhuhuh");
          }, 200, 50),
          RoundedButton("JOIN", () {
            showDialog(
                context: context,
                builder: (BuildContext buildContext) {
                  return BingoAlert();
                });
          }, 200, 50)
        ]),
      ),
    );
  }

  Future createRoom(BuildContext context, String name) async {
    // context.read<UserProvider>().setUserName(name);

    final roomRef = await FirebaseDatabase.instance.reference().child('rooms');
    final roomId = generateRandomString(5);
    final roomModel = RoomModel(roomId, {name: ''}, false);
    roomRef
        .child(roomId)
        // .set({'hello': 'world'}).whenComplete(() {
        .set(roomModel.toJson())
        .whenComplete(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BingoMain()));
    });
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join()
        .toString();
  }
}
