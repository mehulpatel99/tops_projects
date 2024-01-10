import 'dart:convert';

import 'package:digitalsociety/get_members.dart';
import 'package:digitalsociety/member_reg.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class model {
  int? id;
  String? email;
  String? pass;
  model({required this.id, required this.email, required this.pass});

  factory model.fromjson(Map<String, dynamic> json) {
    return model(id: json['id'], email: json['email'], pass: json['pass']);
  }
}

TextEditingController emailcon = TextEditingController();
TextEditingController passcon = TextEditingController();

class MyChairman extends StatefulWidget {
  const MyChairman({super.key});

  @override
  State<MyChairman> createState() => _MyChairmanState();
}

var formkey = GlobalKey<FormState>();

class _MyChairmanState extends State<MyChairman> {
  Future mylogin(String email, String pass) async {
    final response = await http.post(
        Uri.parse('https://unmusical-boil.000webhostapp.com/loginchair.php'),
        body: {
          'email': email,
          'pass': pass,
        });
    List jsonresponse = jsonDecode(response.body);
    if (jsonresponse.isEmpty) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('invalid')));
    } else {
      if (response.statusCode == 200) {
        jsonresponse.map((e) => model.fromjson(e));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Get_MemberData()));
      } else {
        throw Exception('something went wrong ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://global.discourse-cdn.com/elastic/original/3X/9/0/90df22ab443662d632838fd82f6ea38b2cba025a.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Lottie.network(
                    'https://lottie.host/15ee3874-c223-4c70-99f9-16d2d9639e36/GlPGQX5NEx.json',
                    height: 200),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: emailcon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      }
                      null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    controller: passcon,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            mylogin(emailcon.text, passcon.text);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 30),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login with ?',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register_Screen()));
                        },
                        child: Text(
                          'Member',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
