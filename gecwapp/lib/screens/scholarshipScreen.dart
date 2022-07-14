import 'package:flutter/material.dart';
import 'package:gecwapp/Models/scholarshipModel.dart';
import 'package:gecwapp/customWidgets/scholarshipItem.dart';

class ScholarshipScreen extends StatelessWidget {
  final dataset = ScholarshipModel.scholarshipData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          child: ListView.separated(
            shrinkWrap: true,
            // physics: ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20);
            },
            itemCount: dataset.length,
            itemBuilder: (BuildContext context, int index) {
              return ScholarshipItem(dataset[index]);
            },
          ),
        ),
      ),
    );
  }
}
