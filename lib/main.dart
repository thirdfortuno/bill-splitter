import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Splitter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numPeople = 0;


  @override
  Widget build(BuildContext context) {
    return(
      Material(
        child: Center(
          child: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text("How many people are dining?"),
                Row(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                      ),
                      onPressed: (){

                      },
                    ),
                    Container(
                      height: 40,
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                      ),
                      onPressed: (){

                      },
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
