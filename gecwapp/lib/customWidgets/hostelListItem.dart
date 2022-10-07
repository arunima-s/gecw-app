import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/hostelListModel.dart';
import 'package:gecwapp/Providers/gw_values_provider.dart';
import 'package:gecwapp/Providers/hostels_provider.dart';
import 'package:gecwapp/customWidgets/imagebanner.dart';
import 'package:gecwapp/screens/HostelScreens/hostelDetailsScreen.dart';
import 'package:provider/provider.dart';

class HostelListItem extends StatelessWidget {
  final HostelListModel hostelListModel;
  HostelListItem(this.hostelListModel);

  @override
  Widget build(BuildContext context) {
    // final hostelListModel = context.watch<HostelProvider>().hostels[index];
    final screenHeight = context.watch<GWValuesProvider>().height;
    final screenWidth = context.watch<GWValuesProvider>().width;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      // width: MediaQuery.of(context).size.width * 0.8,
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
      // margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageBanner(hostelListModel.images.first, screenHeight * 0.35,
              screenWidth * 0.95),
          Container(
            // color: Colors.yellow,
            // margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            hostelListModel.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // hostelListModel.isBoys
                          //     ? Icon(Icons.male)
                          //     : Icon(Icons.female)
                        ],
                      ),
                      Text(
                        "${hostelListModel.distance} kms from college",
                        style: TextStyle(fontSize: 10),
                      ),
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
