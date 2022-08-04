import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gecwapp/screens/Bingo-Screens/bingo-main.dart';
import 'package:provider/provider.dart';

class AlertScreen extends StatelessWidget {
  // const AlertScreen({Key? key}) : super(key: key);
  var isAdmin;
  final String hintString, buttonTitle, name;
  final bool hasLabel;
  AlertScreen(this.hintString, this.buttonTitle, this.hasLabel, this.name);
  TextEditingController roomIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!name.isEmpty) {
      // context.read<UserProvider>().setUserName(name);
    }
    // isAdmin = context.watch<UserProvider>().isAdmin;
    // userName = context.watch<UserProvider>().userName;
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      content: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasLabel
                ? TextField(
                    // keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: roomIdController,
                    decoration: InputDecoration(
                        hintText: hintString,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        fillColor: Colors.white,
                        filled: true),
                  )
                : SizedBox(),
            //Button
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)))),
                  onPressed: () {
                    print('oombikko myre');
                    // isAdmin
                    //     ? createRoom(context, roomIdController.text)
                    //     : (alertType == AlertType.name)
                    //         ? showDialog(
                    //             context: context,
                    //             builder: (BuildContext buildContext) {
                    //               final name = roomIdController.text;

                    //               // addNameTapped(context);
                    //               return AlertScreen('Room ID', 'Join Room',
                    //                   true, AlertType.join, name);
                    //             })
                    // :
                    //  joinRoomTapped(context, name);

                    // createTransactions(widget.expense, widget.income);
                  },
                  child: Text(
                    buttonTitle,
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  addNameTapped(BuildContext context) {
    print('..00000000000000000name tapped0000000000');
    // context.read<UserProvider>().setUserName(roomIdController.text);
  }

  // joinRoomTapped(BuildContext context, String name) {
  //   print('111111111111111111111join taped111111111111111');
  //   final roomRef = FirebaseDatabase.instance.ref().child(FirebaseKeys.rooms);
  //   final roomId = roomIdController.text;
  //   // final roomModel = RoomModel(roomId, 'dummy', {1: 'njan'}, false);
  //   roomRef.child(roomId).child('players').child(name).set('')
  //       // .set({'hello': 'world'}).whenComplete(() {
  //       // .set({'nee': 'spy'})
  //       .whenComplete(() {
  //     Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) => BingoMain()));
  //   });
  // }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join()
        .toString();
  }
}

//////////////
/////////////EndGame Alert
///