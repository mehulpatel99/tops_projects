import 'dart:convert';

import 'package:digitalsociety/Notice/noticemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoticeAdd extends StatefulWidget {
  const NoticeAdd({super.key});

  @override
  State<NoticeAdd> createState() => _NoticeAddState();
}

TextEditingController titleCon = TextEditingController();
TextEditingController descCon = TextEditingController();



var formkey = GlobalKey<FormState>();
class _NoticeAddState extends State<NoticeAdd> {
 Future<noticemodel> noticepost(String title,String description)async{
  final response = await http.post(Uri.parse('https://unmusical-boil.000webhostapp.com/addnotice.php'),
  body: {
    'title':title,
    'description':description
  },
  );
  // List jsonresponse = jsonDecode(response.body);
  if(response.statusCode==200){
    print('succesfully post');
    return noticemodel.fromjson(jsonDecode(response.body));
  }else{
    throw Exception('Something went wrong');
  }
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
           key: formkey,
          child: Container(
            height: 400,
            width: 400,
            child: Card(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text('Add Your Notice',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
              
              
                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
                  child: TextFormField(
                    controller: titleCon,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Topic is required';
                      }return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.topic),
                      hintText: 'Topic',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  child: TextFormField(
                    controller: descCon,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Desc is required';
                      }return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.topic),
                      hintText: 'Description',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(formkey.currentState!.validate()){
                     noticepost(titleCon.text, descCon.text);
                  }
                }, child: Text('Submit'))
              ],),
            ),
          ),
        ),
      ),
    );
  }
}