import 'package:flutter/material.dart';

class noticemodel
{
  String? id;
  String? title;
  String? description;

  noticemodel({required this.id,required this.title,required this.description});

  factory noticemodel.fromjson(Map<String,dynamic> json){
    return noticemodel(id: json['id'], title: json['title'], description: json['description']);
  }
}