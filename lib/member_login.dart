import 'dart:convert';

import 'package:digitalsociety/get_members.dart';
import 'package:digitalsociety/member_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Member_login extends StatefulWidget {
  const Member_login({super.key});

  @override
  State<Member_login> createState() => _Member_loginState();
}


TextEditingController emailmember = TextEditingController();
TextEditingController passmember = TextEditingController();
class _Member_loginState extends State<Member_login> {
  Future<void> memberlogin(String eamil,pass)async{
    final response = await http.post(Uri.parse('https://unmusical-boil.000webhostapp.com/loginmember.php'),body: 
    {
      'email':eamil,
      'pass':pass
    });
    List jsonresponse = jsonDecode(response.body);
    if(jsonresponse.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid')));
    }else{
      if(response.statusCode==200){
         jsonresponse.map((e) => membermodel.fromjson(e) as Map<String,dynamic>);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>Get_MemberData()));
      }else{
        throw Exception('something went wrong');
      }
    }
  }
  var formkey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey2,
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailmember,
                  validator: (value){
                    if(value!.isEmpty){
                        return 'required this field';
                    }null;
                  },
                  decoration: InputDecoration(hintText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                ),
                  TextFormField(
                  controller: passmember,
                  validator: (value){
                    if(value!.isEmpty){
                        return 'required this field';
                    }null;
                  },
                  decoration: InputDecoration(hintText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                ),
                ElevatedButton(onPressed: (){
                  if(formkey2.currentState!.validate()){
                    memberlogin(emailmember.text, passmember.text);
                  }
                }, child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}