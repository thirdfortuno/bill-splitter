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
  final _node = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState(){
    super.initState();
    _controller.addListener(_peopleListener);
    _node.addListener(_peopleListener);
  }

  void _peopleListener(){
    setState(() {
      if(_node.hasFocus){
        numPeople = int.parse(_controller.value.text);
      }
      if (!_node.hasFocus){
        _controller.value = _controller.value.copyWith(text: numPeople.toString());
      }
    });
  }

  @override
  void dispose(){
    _node.removeListener(_peopleListener);
    _node.dispose();
    _controller.dispose();
    super.dispose();
  }

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
                        _node.unfocus();
                        if(numPeople > 0){
                          numPeople -= 1;
                        } 
                        _peopleListener();
                      },
                    ),
                    Container(
                      height: 40,
                      width: 50,
                      child: TextField(
                        focusNode: _node,
                        controller: _controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                      ),
                      onPressed: (){
                        _node.unfocus();
                        numPeople += 1;
                        _peopleListener();
                      },
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(height: 20),
                InkWell(
                  child: Text("Next Page"),
                  onTap: (){
                    print("$numPeople");
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
