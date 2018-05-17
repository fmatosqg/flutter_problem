import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: buildTheme(Colors.blue),
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
            new SubtreeText('Hello world - tentative blue'),
            new Theme(
              data: buildTheme(Colors.red),
              child: new SubtreeText('Hello world - tentative red'),
            ),
            new Theme(
              data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(
                      color: Colors.orange,
                    ),
                  ),
              child: new Icon(
                Icons.build,
                color: Colors.red,
              ),
            ),
            new Theme(
              data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(
                      color: Colors.orange,
                    ),
                  ),
              child: new ImageIcon(NetworkImage(
                  'https://github.com/google/material-design-icons/blob/master/alert/drawable-xxxhdpi/ic_error_outline_black_36dp.png?raw=true')),
            ),
            SvgImage.network(
              'https://github.com/google/material-design-icons/blob/master/alert/svg/production/ic_warning_36px.svg?raw=true',
              Size(IconTheme.of(context).size, IconTheme.of(context).size),
            ),
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

class SubtreeText extends StatelessWidget {
  final String text;

  SubtreeText(this.text);

  @override
  Widget build(BuildContext context) {
    ThemeData data = Theme.of(context);
    return Text(
      text,
      style: data.textTheme.body1,
    );
  }
}

ThemeData buildTheme(Color textColor) {
  return new ThemeData(
    textTheme: new TextTheme(
      body1: new TextStyle(color: textColor),
    ),
  );
}

class ThemedIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Icon(Icons.add);
  }
}
