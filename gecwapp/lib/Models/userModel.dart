import 'package:flutter/material.dart';

class UserModel {
  final String mail;
  final int access;
  final bool isMember;

  UserModel(this.mail, this.access, this.isMember);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      // : id = json['id'] as String,
      : mail = json['mail'] as String,
        access = json['access'] as int,
        isMember = json['bicycle'] as bool;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'mail': mail, 'access': access, 'bicycle': isMember};
}
