import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_training/Fruit.dart';
import 'Calculator.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  List<Fruit> fruitName = [
    Fruit(fruitName: "Apple", fruitColor: "Red"),
    Fruit(fruitName: "Oranges", fruitColor: "Orange"),
    Fruit(fruitName: "Cherries", fruitColor: "Red"),
    Fruit(fruitName: "Cranberries", fruitColor: "Red"),
    Fruit(fruitName: "Grapes", fruitColor: "Purpule"),
    Fruit(fruitName: "Pears", fruitColor: "Red"),
    Fruit(fruitName: "Pomegranates", fruitColor: "Red"),
    Fruit(fruitName: "Raspberries", fruitColor: "Pink"),
    Fruit(fruitName: "Strawberries", fruitColor: "Red"),
  ];

  Widget fruitTemplate(fruit) {
    return FruitCard(fruit: fruit);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Listview"),
          ),
          body: ListView(
            /*
          children: fruitName
              .map(
                  (e) => Text('Fruit: ${e.fruitName} has Color: ${e.fruitColor}'))
              .toList(),*/
            children: fruitName.map((fruit) => fruitTemplate(fruit)).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorApp()),
              );
            },
            child: Text(
              ">",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ));
  }
}

class FruitCard extends StatelessWidget {
  final Fruit fruit;

  const FruitCard({
    required this.fruit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellowAccent,
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                fruit.fruitName,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(
                width: 10.0,
                height: 10.0,
              ),
              Text(
                fruit.fruitColor,
                style: TextStyle(fontSize: 15.0, color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
