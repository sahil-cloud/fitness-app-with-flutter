import 'dart:convert';
import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/ehub.dart';
import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayer/audioplayer.dart';
  

class HomeFit extends StatefulWidget {
  @override
  _HomeFitState createState() => _HomeFitState();
}

class _HomeFitState extends State<HomeFit> {
  final String url =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  Ehub ehub;

  @override
  void initState() {
    getexercises();
    super.initState();
  }

  void getexercises() async {
    var res = await http.get(url);
    var body = res.body;

    var decoded = jsonDecode(body);

    ehub = Ehub.fromJson(decoded);
    setState(() {});
  }

  // void Startscreen(e){
  //   // print(e);
  //   new Container(
  //     child: new Text("sahil"),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("ExerciseHub"),
        centerTitle: true,
      ),
      body: new Container(
        child: ehub != null
            ? ListView(
                children: ehub.exercises
                    .map((e) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen(
                                          exercises: e,
                                        )));
                          },
                          child: Hero(
                            tag: e.id,
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Stack(children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: FadeInImage(
                                    placeholder: AssetImage('assets/kat.jpg'),
                                    image: NetworkImage(e.thumbnail),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: new Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    decoration: new BoxDecoration(
                                        gradient: new LinearGradient(
                                            colors: [
                                          Color(0xFF000000),
                                          Color(0x00000000),
                                        ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center)),
                                  ),
                                ),
                                new Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 250,
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 15),
                                  child: new Text(
                                    e.title,
                                    style: new TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ))
                    .toList(),
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}

class StartScreen extends StatefulWidget {
  final Exercises exercises;
  StartScreen({this.exercises});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int seconds = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: new Hero(
        tag: widget.exercises.id,
        child: Stack(
          children: <Widget>[
            new CachedNetworkImage(
              imageUrl: widget.exercises.thumbnail,
              placeholder: (context, url) => Image(
                image: AssetImage("assets/kat.jpg"),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                Color(0xFF000000),
                Color(0x00000000),
              ], begin: Alignment.bottomCenter, end: Alignment.center)),
            ),
            new Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: new Container(
                height: 175,
                width: 175,
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  onChange: (double value) {
                    seconds = value.toInt();
                  },
                  min: 10,
                  max: 60,
                  initialValue: 30,
                  innerWidget: (v) {
                    return Container(
                      alignment: Alignment.center,
                      child: new Text(
                        "${v.toInt()} S",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            new Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExerciseScreen(
                                exercises: widget.exercises,
                                seconds: seconds,
                              )));
                },
                child: new Text(
                  "Start Exercise",
                  style: new TextStyle(
                    fontSize: 20,
                  ),
                ),
                color: Color(0xFFE83350),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                splashColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;
  final int seconds;

  ExerciseScreen({this.exercises, this.seconds});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;

  Timer timer;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == widget.seconds) {
        t.cancel();

        setState(() {
          _isCompleted = true;
        });
        
        PlayAudio();

      }
      setState(() {
        _elapsedSeconds = t.tick;
      });
    });

    super.initState();
  }

  void PlayAudio() async{
    await audioCache.play("assets/audio.mp3");
  }

//  void playLocal() {
//     audioPlayer.play("audio.mp3", isLocal: true);
//   }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
          children: <Widget>[
            Center(
              child: new CachedNetworkImage(
                imageUrl: widget.exercises.gif,
                placeholder: (context, url) => Image(
                  image: AssetImage("assets/kat.jpg"),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            _isCompleted != true ? new SafeArea(
              child: new Container(
                padding: EdgeInsets.only(top:20),
                alignment: Alignment.topCenter,
                child: new Text("$_elapsedSeconds/${widget.seconds} S" ,
                style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ) :
              new Container(
                 
              ),
            new SafeArea(
              child: Container(
                padding: EdgeInsets.only(top:5,left:5),
                child: IconButton(icon: Icon(Icons.close)
                , onPressed: () {
                  Navigator.of(context).pop();
                }),
              ),
            ),
          ],
        ),
      
    );
  }
}
