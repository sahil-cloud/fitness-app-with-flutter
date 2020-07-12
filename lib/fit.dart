import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'fith.dart';

class FitApp extends StatefulWidget {
  @override
  _FitAppState createState() => _FitAppState();
}

class _FitAppState extends State<FitApp> {

  @override
  Widget build(BuildContext context) {
  // creating array for onboarding screen
  var pages = [
    PageViewModel(
      title: "Welcome to iExercise",
      body:
          "Train your body and mind according to the our different Exercises",
      image: Container(
        child: Image.asset("assets/e1.jpg",
        height: 175.0,
        // width : MediaQuery.of(context).size.width,
        // fit: BoxFit.cover,
        ),
        
      ),
      decoration: const PageDecoration(pageColor: Colors.blue),
    ),
    PageViewModel(
      title: "Train your body and Mind",
      body:
          "Our app provides you the best exercises to get started and get along",
      image: Container(
        child: Image.asset("assets/e2.jpg", height: 125.0,
        // width : MediaQuery.of(context).size.width,
        // fit: BoxFit.cover,
        ),
      ),
      decoration: const PageDecoration(pageColor: Colors.blue),
    ),
    PageViewModel(
      title: "So Let's Start",
      body:
          "Click done and unloack the beautiful journey",
      image: Container(
        child: Image.asset("assets/kat.jpg", height: MediaQuery.of(context).size.height,
        width : MediaQuery.of(context).size.width,
        fit: BoxFit.cover,),
      ),
      decoration: const PageDecoration(pageColor: Colors.blueAccent),
    ),
    
  ];
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        onDone: () {
          // When done button is press
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeFit())
          );
        },
        onSkip: () {
          // we can also override onSkip callback
          Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeFit())
          );
        },
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.arrow_right),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.deepOrange,
            color: Colors.black,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
