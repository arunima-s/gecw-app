import 'package:flutter/material.dart';

class UserModel {
  final String mail;
  final int access;
  final bool isMember;
  final String? club;

  UserModel(this.mail, this.access, this.isMember, this.club);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      // : id = json['id'] as String,
      : mail = json['mail'] as String,
        access = json['access'] as int,
        isMember = json['bicycle'] as bool,
        club = json['club'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'mail': mail,
        'access': access,
        'bicycle': isMember,
        'club': club
      };
}
