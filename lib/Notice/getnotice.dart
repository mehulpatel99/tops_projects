import 'dart:convert';

import 'package:digitalsociety/Notice/deletenotice.dart';
import 'package:digitalsociety/Notice/noticemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetNotice extends StatefulWidget {
  const GetNotice({super.key});

  @override
  State<GetNotice> createState() => _GetNoticeState();
}

class _GetNoticeState extends State<GetNotice> {
  Future<List<noticemodel>> getnotice()async{
    final response = await http.get(Uri.parse('https://unmusical-boil.000webhostapp.com/getnotice.php'));
    List jsonresponse = jsonDecode(response.body);
    if(response.statusCode==200){
      return jsonresponse.map((e) => noticemodel.fromjson(e)).toList();
    }else{
      throw  Exception('something went wrong');
    }
  }

   Future<void> deletenotice(String id)async{
   final response = await http.post(Uri.parse('https://unmusical-boil.000webhostapp.com/deletenotice.php'),body: {
    'id':id,
   });
   if(response.statusCode==200){
    noticemodel.fromjson(jsonDecode(response.body));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GetNotice()));
   }else{
    throw Exception('something went wrong');
   }
  }

 late Future<List<noticemodel>> futuredata;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuredata=getnotice();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future:futuredata, builder: (context,snapshot){
        if(snapshot.hasData){
          List<noticemodel> mylist = snapshot.data!;
          return ListView.builder(itemCount: mylist.length,itemBuilder: (context,index){
            return Card(child: Column(children: [
              Text('Id : ${mylist[index].id}'),
              Text('Id : ${mylist[index].title}'),
              Text('Id : ${mylist[index].description}'),
              ElevatedButton.icon(onPressed: (){
                setState(() {
                  deletenotice(mylist[index].id!);
                });
                
              }, icon: Icon(Icons.delete), label: Text('delete'))
            ],),);
          });
        }else if(snapshot.hasError){
          Center(child: Text('Error'));
        }return Center(child: CircularProgressIndicator());
      }, ),
    );
  }
}