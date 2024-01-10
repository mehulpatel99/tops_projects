import 'package:digitalsociety/Notice/getnotice.dart';
import 'package:digitalsociety/Notice/noticeadd.dart';
import 'package:digitalsociety/chairman.dart';
import 'package:digitalsociety/complaint/addcomplain.dart';
import 'package:digitalsociety/get_members.dart';
import 'package:digitalsociety/member_login.dart';
// import 'package:digitalsociety/home.dart';
import 'package:digitalsociety/member_reg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:addcomplain(),
    );
  }
}
