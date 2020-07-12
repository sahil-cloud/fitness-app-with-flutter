

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var num1 =0 ,num2 =0 ,sum=0;
  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");

  void doAdd(){
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 + num2;
    });
  }
  void doSub(){
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 - num2;
    });
  }
  void doMul(){
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 * num2;
    });
  }
  void doDiv(){
    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);
      sum = num1 ~/ num2;
    });
  }
  void doClr(){
    setState(() {
      t1.text = "0";
      t2.text ="0";
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: new Container(
          padding: const EdgeInsets.all(50.0),
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // new Padding(padding: const EdgeInsets.all(50.0)),

              new Column(
                
                children: <Widget>[
                  new Text('Output:  $sum',

                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  
                  ),
                  
                ],

                
              ),
             new TextFormField(
               keyboardType: TextInputType.number,
               decoration: new InputDecoration(
                 hintText: "Enter Num 1"
               ),
               controller: t1,
             ),
             new TextFormField(
               keyboardType: TextInputType.number,
               decoration: new InputDecoration(
                 hintText: "Enter Num 2"
               ),
               controller: t2,
             ),
             new Padding(padding: const EdgeInsets.only(top: 15.0)),
             new Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 new RaisedButton(onPressed: doAdd,
                  color: Colors.teal,
                  child: new Text('+'),
                 ),
                 new RaisedButton(onPressed: doSub,
                  color: Colors.teal,
                  child: new Text('-'),
                 ),
               ],
             ),
             new Padding(padding: const EdgeInsets.only(top: 15.0)),
             new Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 new RaisedButton(onPressed: doMul,
                  color: Colors.teal,
                  child: new Text('*'),
                 ),
                 new RaisedButton(onPressed: doDiv,
                  color: Colors.teal,
                  child: new Text('/'),
                 ),
               ],
             ),
             new Padding(padding: const EdgeInsets.only(top: 15.0)),
             new Row(
               mainAxisAlignment: MainAxisAlignment.center,

               children: <Widget>[
                 new RaisedButton(onPressed: doClr,
                  color: Colors.teal,
                  child: new Text('clear'),
                 ),
               ],
               
             ),
          ],
        ),
      ),
    );
  }
}