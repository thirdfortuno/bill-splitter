import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Person {
  int id;
  String name;
  double payment;
  List<int> ordersId = new List();

  Person(id,name){
    this.id = id;
    this.name = name;
    this.payment = 0;
  }

}

class Order {
  int id;
  String name;
  double cost;
  List<int> peopleId = new List();

  Order(id,name,cost,peopleId){
    this.id = id;
    this.name = name;
    this.cost = cost;
    this.peopleId = peopleId;
  }
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
  List<Person> people;
  List<Order> orders = new List();

  final foodNameController = new TextEditingController();
  final foodCostController = new TextEditingController();

  @override
  void initState(){
    super.initState();
    people = List.generate(widget.numPeople, (int i) => new Person(i,"Person ${i + 1}"));
  }

  void addOrder(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        //foodName = "Food Name";
        double foodCost = 1.00;
        foodCostController.addListener((){
          foodCost = double.parse(foodCostController.value.text);
        });
        List names = people.map((x) => x.name).toList();
        List peopleOrdering = people.map((x) => false).toList();
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
                  controller: foodCostController,
                  keyboardType: TextInputType.number,
                ),
                Text("Who is getting this?"),
                Column(
                  children: <Widget>[
                    CheckboxGroup(
                      labels: names,
                      onChange: (bool isChecked, String label, int index) => peopleOrdering[index] = isChecked,
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
                createOrder("hello", foodCost, peopleOrdering);
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

  void createOrder(name, cost, labels){
    var peopleOrdering = List.generate(labels.length, (int i) => i).where((j) => labels[j]).toList();
    Order order = Order(orders.length,name,cost,peopleOrdering);
    peopleOrdering.map((i) => people[i].ordersId.add(orders.length));
    orders.add(order);
  }

  List<Widget> peopleList(){
    List<Widget> list = people.map((Person i) => new PersonCard(i)).toList();
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