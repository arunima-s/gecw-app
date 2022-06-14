import 'package:flutter/material.dart';
import 'package:gecwapp/Screens/semesterScreen.dart';
import 'package:gecwapp/screens/notificationScreen.dart';

class CustomAppBar extends StatelessWidget {
  // const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "WELCOME",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
          ),
          Spacer(),
          IconButton(onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
          }
          
          , icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
}
