import 'package:flutter/material.dart';

class membermodel {
  String? id;
  String? name;
  String? contact;
  String? houseno;
  String? email;
  String? pass;

  membermodel(
      {required this.id,
      required this.name,
      required this.contact,
      required this.houseno,
      required this.email,
      required this.pass});

  factory membermodel.fromjson(Map<String, dynamic> json) {
    return membermodel(
        id: json['id'],
        name: json['name'],
        contact: json['contact'],
        houseno: json['houseno'],
        email: json['email'],
        pass: json['pass']);
  }
}
