import 'package:flutter/material.dart';

class ScholarshipScreen extends StatelessWidget {
  final dataset = ScholarshipModel.scholarshipData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [ScholarshipItem(dataset.first)],
          ),
        ),
      ),
    );
  }
}

class ScholarshipItem extends StatelessWidget {
  final ScholarshipModel scholarShipData;
  ScholarshipItem(this.scholarShipData);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
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
                ElevatedButton(onPressed: null, child: Text("More Details")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ScholarshipModel {
  final String name, amount, eligiblity, income, url;

  ScholarshipModel(
      this.name, this.amount, this.eligiblity, this.income, this.url);

  static final scholarshipData = [
    ScholarshipModel("E GRANTZ", "50k per annum", "SC/ ST/ OBC/ OEC",
        "No Limit", "https://google.com")
  ];
}
