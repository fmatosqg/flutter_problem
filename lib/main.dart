import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new rpi3(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class rpi3 extends StatefulWidget {
  @override
  _rpi3State createState() => _rpi3State();
}

class _rpi3State extends State<rpi3> {
  Timer _periodicTimer;
  Timer _dutyCycleTimer;

  bool _isLedOn = false;
  int _dutyCyclePercentage = 50; // from 0 to 100
  int _ducyCycleCounter = 0;

  @override
  void initState() {
    super.initState();

    _periodicTimer =
        new Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  @override
  void reassemble() {
    super.reassemble();

    _periodicTimer?.cancel();
    _periodicTimer =
        new Timer.periodic(const Duration(milliseconds: 10000), (Timer timer) {
      updateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void updateTime() async {
    var dt = new DateTime.now();

    String path = '/sys/class/gpio/gpio26/value';
    File file = new File.fromUri(new Uri.file(path));

    await file.open(mode: FileMode.write);

    print("Update time  $dt");

    _dutyCycleTimer?.cancel();

    _dutyCyclePercentage = 10;
    _dutyCycleTimer =
        new Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      file.writeAsStringSync(
          _ducyCycleCounter < _dutyCyclePercentage ? "1" : "0");
      _ducyCycleCounter += 10;
      if (_ducyCycleCounter >= 100) {
        _ducyCycleCounter = 0;
      }
    });
  }
}
