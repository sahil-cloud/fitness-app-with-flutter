import 'package:flutter/material.dart';
import 'home.dart';
import 'json.dart';
import 'fit.dart';

void main() => runApp(
  new MyApp()
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       home: new FitApp(),
       theme: new ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF192A56)
        )
       ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {


  // providing animation
  AnimationController _iconAnimationController ;
  Animation<double> _iconAnimation;

  @override
  // void @override
  void initState() { 
    super.initState();
    _iconAnimationController = new AnimationController(vsync: this,
      duration: new Duration(
      milliseconds:500
    ) );
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, 
    curve: Curves.easeInOut);

    _iconAnimation.addListener(() => this.setState(() { })); //adding listner
    _iconAnimationController.forward(); //it will start running
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value  * 100,
              ),
              new Form(
                child: new Theme(
                  data: new ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.teal,
                    inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  child: new Container(
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      new Padding(padding: const EdgeInsets.only(top: 20.0)),
                      new MaterialButton(
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Login"),
                        onPressed: () => {},
                        splashColor: Colors.greenAccent,
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}