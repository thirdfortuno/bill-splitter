import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Person {
  int id;
  String name;
  double payment;
  List<int> ordersId;

  Person(id,name){
    this.id = id;
    this.name = name;
    this.payment = 0;
  }

}

class Order {
  int id;
  String name;
  int cost;
  List<int> peopleId;
}

class PersonCard extends StatelessWidget{
  PersonCard([
    this.person,
  ]);

  final Person person;

  @override
  Widget build(BuildContext context){
    return(
      Card(
        child: Container(
          child: Row(
            children: <Widget>[
              Container(),
              Column(
                children: <Widget>[
                  Text(
                    person.name,
                  ),
                  Text(
                    "${person.payment.toStringAsFixed(2)}",
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

class TableScreen extends StatefulWidget{
  const TableScreen({
    Key key,
    this.numPeople,
  });

  final int numPeople;

  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen>{
  List<Person> people = new List();
  List<Order> orders = new List();

  void initTable(){
    for(int i = 0; i < widget.numPeople; i++){
      Person person = new Person(i,"Person ${i + 1}");
      people.add(person);
    }
  }

  void addOrder(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        //String name = "Food Name";
        //double cost = 1.00;
        List<String> names = new List();
        for(int i = 0; i < people.length; i++){
          names.add(people[i].name);
        }
        return AlertDialog(
          title: Text("Add Order"),
          content: Container(
            child: Column(
              children: <Widget>[
                Text("Enter name:"),
                TextField(
                ),
                Text("Enter cost:"),
                TextField(
                  keyboardType: TextInputType.number,
                ),
                Text("Who is getting this?"),
                Column(
                  children: <Widget>[
                    CheckboxGroup(
                      labels: names,
                      onSelected: (List<String> checked) => print(checked.toString())
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Enter"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  void initState(){
    super.initState();
    initTable();
  }

  List<Widget> peopleList(){
    List<Widget> list = new List();
    for(int i = 0; i < widget.numPeople; i++){
      PersonCard item = PersonCard(people[i]);
      list.add(item);
    }
    return list;
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return(
      Material(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            InkWell(
              child: Container(
                height: 100,
                child: Text("Add Order"),
              ),
              onTap: (){
                addOrder();
              },
            ),
            Column(
              children: peopleList(),
            ),
          ],
        ),
      )
    );
  }
}