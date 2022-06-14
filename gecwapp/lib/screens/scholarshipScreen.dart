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
          child: ListView(
            children: [ScholarshipItem(dataset.first)],
          ),
        ),
      ),
    );
  }
}
