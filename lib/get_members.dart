import 'dart:convert';

import 'package:digitalsociety/member_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get_MemberData extends StatefulWidget {
  const Get_MemberData({super.key});

  @override
  State<Get_MemberData> createState() => _Get_MemberDataState();
}

class _Get_MemberDataState extends State<Get_MemberData> {
  Future<List<membermodel>> myget() async {
    final response = await http.get(
        Uri.parse('https://unmusical-boil.000webhostapp.com/getmember2.php'));
    List jsonresponse = jsonDecode(response.body);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print('Succesfully getdata');
      return jsonresponse.map((data) => membermodel.fromjson(data)).toList();
    } else {
      throw Exception('something went wrong');
    }
  }

  Future<void> mydelete(String id) async {
    final response = await http.post(
        Uri.parse('https://unmusical-boil.000webhostapp.com/deletemember.php'),
        body: {
          'id': id,
        });

    if (response.statusCode == 200) {
      membermodel.fromjson(jsonDecode(response.body));

      Navigator.push(
          context, MaterialPageRoute(builder: (Context) => Get_MemberData()));
    } else {
      throw Exception("something went wrong ");
    }
  }

  late Future<List<membermodel>> futuredata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuredata = myget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.lightBlue,Colors.blueGrey,Colors.greenAccent],begin: Alignment.topLeft,end: Alignment.bottomRight
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        
        appBar: AppBar(
          title: Text('Society Members'),
          backgroundColor: Colors.transparent,
          
        ),
        body: FutureBuilder(
            future: futuredata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<membermodel> mylist = snapshot.data!;
                return GridView.builder(
                    itemCount: mylist.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Icon(Icons.person,size: 40,),),
                              ],
                            ),
                            Text('Name : ${mylist[index].name}'),
                            Text('Contact : ${mylist[index].contact}'),
                            Text('HouseNo  : ${mylist[index].houseno}'),
                            Text('Email : ${mylist[index].email}'),
                            Text('Pass : ${mylist[index].pass}'),
                            Center(
                              child: ElevatedButton.icon(
                                label: Text('Delete'),
                                  onPressed: () {
                                    setState(() {
                                      mydelete(mylist[index].id!);
                                    });
                                  },
                                  icon: Icon(Icons.delete,color: Colors.red,)),
                            )
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                Text('Error');
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
