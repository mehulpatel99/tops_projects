import 'dart:convert';

import 'package:digitalsociety/member_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Register_Screen extends StatefulWidget {
  const Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

bool visible = false;
var formkey = GlobalKey<FormState>();
TextEditingController name2 = TextEditingController();
TextEditingController contact2 = TextEditingController();
TextEditingController houseno2 = TextEditingController();
TextEditingController email2 = TextEditingController();
TextEditingController pass2 = TextEditingController();

class _Register_ScreenState extends State<Register_Screen> {
  Future<membermodel> mypost(String name, contact, houseno, email, pass) async {
    final response = await http.post(
        Uri.parse('https://unmusical-boil.000webhostapp.com/addmember2.php'),
        body: {
          'name': name,
          'contact': contact,
          'houseno': houseno,
          'email': email,
          'pass': pass
        });
    if (response.statusCode == 200) {
      print('Succesfully register');
      return membermodel.fromjson(jsonDecode(response.body));
    } else {
      throw Exception('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Form(
              key: formkey,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    // color: Colors.grey[400],
                    gradient: LinearGradient(colors: [Colors.green,Colors.blueGrey,Colors.blue],begin: Alignment.topLeft,end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(50, 50),
                        topRight: Radius.elliptical(50, 50))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LottieBuilder.network(
                        'https://lottie.host/69e03a8d-1804-47a0-bb0f-f3606e6e975e/aXwwSxtGeo.json',
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: TextFormField(
                          controller: name2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                            null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(Icons.text_fields),
                              label: Text('Name',style: TextStyle(color: Colors.black,fontSize: 20),),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 10,
                        ),
                        child: TextFormField(
                          controller: contact2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Contact is required';
                            }
                            null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Contact',
                              prefixIcon: Icon(Icons.contact_mail),
                              label: Text('Contact',style: TextStyle(color: Colors.black,fontSize: 20)),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          controller: houseno2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Houseno is required';
                            }
                            null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Houseno',
                              prefixIcon: Icon(Icons.house),
                              label: Text('HouseNo.',style: TextStyle(color: Colors.black,fontSize: 20)),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          controller: email2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            null;
                          },
                          decoration: InputDecoration(
                            label: Text('Email',style: TextStyle(color: Colors.black,fontSize: 20)),
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          controller: pass2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            null;
                          },
                          obscureText: !visible,
                          decoration: InputDecoration(
                            label: Text('Password',style: TextStyle(color: Colors.black,fontSize: 20)),
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                       visible = !visible;
                                    });
                                   
                                  },
                                  icon: Icon(visible?  Icons.visibility : Icons.visibility_off)),
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment(0.3,1),colors: [Colors.purple,Colors.pink,Colors.orange])),
                          child: TextButton(
                            
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                mypost(name2.text, contact2.text, houseno2.text,
                                    email2.text, pass2.text);
                              }
                            },
                            child: Text(
                              'Register',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 15, color: Colors.white,),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130,left: 20),
            child: LottieBuilder.network(
                          'https://lottie.host/b410efa5-f74d-4b6f-87d0-c3f02503f413/DpzbTpMA6k.json',
                          height: 150,
                        ),
          ),
        ],
      ),
    );
  }
}
