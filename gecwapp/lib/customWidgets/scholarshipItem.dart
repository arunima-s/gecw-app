import 'package:flutter/material.dart';
import 'package:gecwapp/Constants/strings.dart';
import 'package:gecwapp/Models/scholarshipModel.dart';
import 'package:gecwapp/Styles/buttonStyles.dart';
import 'package:gecwapp/screens/scholarshipScreen.dart';
import 'package:url_launcher/url_launcher.dart';

  class ScholarshipItem extends StatelessWidget {
  final ScholarshipModel scholarShipData;
  ScholarshipItem(this.scholarShipData);
  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      // width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  scholarShipData.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  scholarShipData.amount,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Eligiblity",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      scholarShipData.eligiblity,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Income Limit",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      scholarShipData.income,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {
                  openURL(scholarShipData.url);
                }, child: Text("More Details"),
                style: DetailsButtonStyle(),),
              ],
            ),
          )
        ],
      ),
    );
  }

    Future<void> openURL(String _url) async {
    await launch(_url, forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
}