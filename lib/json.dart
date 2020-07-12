import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class Jsonpage extends StatefulWidget {
  @override
  _JsonpageState createState() => _JsonpageState();
}

class _JsonpageState extends State<Jsonpage> {

// var apiKey = '57516341cc58436a9c5506b5a83a86d0';
final String url = 'http://www.google.com'; 
List data;

  @override
  void initState() { 
    super.initState();
    this.jsondata();
  }

  Future<String> jsondata() async{
    var res = await Dio().get(url
      // Uri.encodeFull(url),
      // headers: {'Accept' : 'application/json'}
    );

  print(res.data);

  // setState(() {
  //   var convertdata = jsonDecode(res);
  //   data = convertdata['data'];
  // });

    return "sucess";

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('JSON File'),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : 1,
        itemBuilder: (BuildContext context , int index){
          return new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Card(
                  child: new Container(
                    child: Text(data[index]['employee_name'],
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
              ],
            ),
          ); 
        }, 
        ),
    
    );
  }
}