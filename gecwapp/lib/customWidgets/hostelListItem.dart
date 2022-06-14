import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Screens/hostelDetailsScreen.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';

class HostelListItem extends StatelessWidget {
  HostelListModel hostelListModel;
  HostelListItem(this.hostelListModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBanner(hostelListModel.image),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        "Adam Villa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                      Text("2000 per month", style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          // padding: MaterialStateProperty.a,
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor)))),
                      onPressed: () => onDetailsTap(context, hostelListModel),
                      child: Text("View Details")),
                ),
                // SizedBox(
                //   width: 0.01,
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onDetailsTap(BuildContext context, HostelListModel hostelListModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HostelDetailsScreen(hostelListModel)));
  }
}
