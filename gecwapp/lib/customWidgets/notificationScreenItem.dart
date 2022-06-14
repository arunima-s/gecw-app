import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/notificationModel.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';



class NotificationScreenItems extends StatelessWidget {
  final NotificationModel notificationItem;
  NotificationScreenItems(this.notificationItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.systemWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey3,
                offset: Offset(2.0, 2.0),
                spreadRadius: 3.0,
                blurRadius: 2.0)
          ]),
          // margin: EdgeInsets.only(top: 10),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image.asset("assets/images/room2.jpeg", width: MediaQuery.of(context).size.width * 0.5,),
          // Image.network(notificationItem.image, width: MediaQuery.of(context).size.width * 0.5,),
          ImageBanner(notificationItem.image, MediaQuery.of(context).size.width * 0.5),
          Container(
            // color: Colors.red,
            width:  MediaQuery.of(context).size.width * 0.3,
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: 
                                  Text(
                        notificationItem.details,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ), 
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            //       child: Column(
            //         children: [
            //           Text(
            //             "Adam Villa",
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 10),
            //           ),
            //           Text("2000 per month", style: TextStyle(fontSize: 20),)
            //         ],
            //       ),
            //     ),
            //     // SizedBox(
            //     //   width: 0.01,
            //     // )
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}