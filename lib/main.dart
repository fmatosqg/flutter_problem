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
        body: new Text(_debugMsg),
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

    _scheduleThemeChange('Second theme', 5, secondThemeData);


  }

  _scheduleThemeChange(String msg, int delaySeconds, ThemeData theme){
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
    primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.yellow);

var secondThemeData = new ThemeData(
    primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.redAccent);
