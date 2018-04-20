import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeData _themeData;
  String _debugMsg;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: _themeData,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Title'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Sample text'),
              new Text(_debugMsg),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _shootThemeTransition();
  }

  @override
  void reassemble() {
    super.reassemble();

    _shootThemeTransition();
  }

  void _shootThemeTransition() {
    _themeData = initialThemeData;
    _debugMsg = 'First theme';
    print(_debugMsg);

    var interval = 2;
    // color changes
    _scheduleThemeChange('Second theme', interval, secondThemeData);

    // font changes
    _scheduleThemeChange('Third theme', interval * 2, thirdThemeData);
    _scheduleThemeChange('Fourth theme', interval * 3, fourthThemeData);
    _scheduleThemeChange('Fifth theme causes glitch', interval * 4, fifthThemeData);
    _scheduleThemeChange('6th theme', interval * 5, sixthThemeData);
    _scheduleThemeChange('7th', interval * 6, seventhThemeData);
//    _scheduleThemeChange('8th', interval * 7, eightThemeData);
  }

  _scheduleThemeChange(String msg, int delaySeconds, ThemeData theme) {
    new Timer(new Duration(seconds: delaySeconds), () {
      setState(() {
        _debugMsg = msg;
        print(_debugMsg);
        _themeData = theme;
      });
    });
  }
}

var initialThemeData = new ThemeData(
    primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.blueGrey);

var secondThemeData = initialThemeData.copyWith(
//    primarySwatch: Colors.red, //---> compile error
  scaffoldBackgroundColor: Colors.purple,
);

///////
// these themes will use 7th version as reference
var thirdThemeData = initialThemeData.copyWith(
//    primarySwatch: Colors.red, //---> compile error
  scaffoldBackgroundColor: Colors.orange,
  textTheme: new TextTheme(
    title: new TextStyle(fontSize: 40.0),
    display4: new TextStyle(fontSize: 10.0),
    display3: new TextStyle(fontSize: 10.0),
    display2: new TextStyle(fontSize: 10.0),
    display1: new TextStyle(fontSize: 10.0),
    headline: new TextStyle(fontSize: 10.0),
    subhead: new TextStyle(fontSize: 10.0),
    body2: new TextStyle(fontSize: 10.0),
    body1: new TextStyle(fontSize: 30.0),
    caption: new TextStyle(fontSize: 10.0),
    button: new TextStyle(fontSize: 10.0),
  ),
);

var fourthThemeData = thirdThemeData.copyWith(
  scaffoldBackgroundColor: Colors.orange,
);

var fifthThemeData = thirdThemeData.copyWith(
  scaffoldBackgroundColor: Colors.orange,
  textTheme: new TextTheme(
    title: new TextStyle(fontSize: 40.0),
    display4: new TextStyle(fontSize: 10.0),
//    display3: new TextStyle(fontSize: 10.0), // uncomment to fix project
    display2: new TextStyle(fontSize: 10.0),
    display1: new TextStyle(fontSize: 10.0),
    headline: new TextStyle(fontSize: 10.0),
    subhead: new TextStyle(fontSize: 10.0),
    body2: new TextStyle(fontSize: 10.0),
    body1: new TextStyle(fontSize: 60.0),
    caption: new TextStyle(fontSize: 10.0),
    button: new TextStyle(fontSize: 10.0),
  ),
);

var sixthThemeData = fourthThemeData;

var seventhThemeData = fourthThemeData.copyWith(
  textTheme: fourthThemeData.textTheme
      .copyWith(body1: new TextStyle(fontSize: 50.0, color: Colors.white70)),
);

// 1- ThemeData copyWith missing primarySwatch
// 2- When hot reload after editing initialThemeData.scaffoldBackgroundColor no changes are noticed, needs full reload, even with transitions between themes. Same with font size changes.
// 3- Small size change on AppBar text when transitioning from first to second theme (it shrinks a bit then comes back)
// 4- transition from 4th to 5th theme causes typography.dart assertion error because display3 is null on 5th theme
// 5- transition from 5th to 6th theme causes typography.dart assertion error because display3 is null on 5th theme
