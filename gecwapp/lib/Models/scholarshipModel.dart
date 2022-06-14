import 'package:flutter/material.dart';

class ScholarshipModel {
  final String name, amount, eligiblity, income, url;

  ScholarshipModel(
      this.name, this.amount, this.eligiblity, this.income, this.url);

  static final scholarshipData = [
    ScholarshipModel("E GRANTZ", "50k per annum", "SC/ ST/ OBC/ OEC",
        "No Limit", "https://google.com")
  ];
}