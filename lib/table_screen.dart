import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Person {
  int id;
  String name;
  double payment;
  double given = 0;
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
    this.givenController,
  ]);

  final Person person;
  final TextEditingController givenController;
  
  void editPerson(context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return(
          AlertDialog(
            title: Text("${person.name}"),
            content: Container(
              child: Column(
                children: <Widget>[
                  Text("Enter given money:"),
                  TextField(
                    controller: givenController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Enter"),
                onPressed: (){
                  person.given = double.parse(givenController.value.text);
                  print(person.given);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){
                  print("cancel");
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return(
      Card(
        child: InkWell(
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
              Spacer(),
              Column(
                children: <Widget>[
                  Text("Given money"),
                  Text("${person.given.toStringAsFixed(2)}"),
                ],
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  Text("Change"),
                  Text("${(person.given-person.payment).toStringAsFixed(2)}"),
                ],
              ),
            ],
          ),
          onTap:(){
            editPerson(context);
          }
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
  final personGivenController = new TextEditingController();

  double foodCost = 0;

  @override
  void initState(){
    super.initState();
    people = List.generate(widget.numPeople, (int i) => new Person(i,"Person ${i + 1}"));
    foodCostController.addListener((){
      foodCost = double.parse(foodCostController.value.text);
    });
  }

  void addOrder(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        //foodName = "Food Name";
        List names = people.map((x) => x.name).toList();
        List peopleOrdering = people.map((x) => false).toList();
        return AlertDialog(
          title: Text("Add Order"),
          content: Container(
            child: Column(
              children: <Widget>[
                Text("Enter cost before selecting people"),
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
                      onChange: (bool isChecked, String label, int index){
                        peopleOrdering[index] = isChecked;
                        print(peopleOrdering);
                        },
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
    for (var i in peopleOrdering) people[i].ordersId.add(orders.length);
    orders.add(order);
    computeCost();
  }

  void computeCost(){
    for (var person in people) person.payment = 0;
    setState(() {
      for (var order in orders){
        var costEach = order.cost/order.peopleId.length;
        print("$costEach = ${order.cost}/${order.peopleId.length}");
        for (var id in order.peopleId) people[id].payment += costEach;
      }
    });
  }

  List<Widget> peopleList(){
    List<Widget> list = people.map((Person i) => new PersonCard(i,personGivenController)).toList();
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
                child: Center(
                  child: Text("Add Order"),
                )
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