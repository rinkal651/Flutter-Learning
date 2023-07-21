import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Fruit.dart';

void main() => runApp(const MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('my first app'),
            centerTitle: true,
            backgroundColor: Colors.red[600]),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    Container(
                        color: Colors.cyanAccent,
                        //EdgeInsets.all apply same for all side, symmetric-vertical, horizontal, fromLTRB all need to be defined
                        padding: const EdgeInsets.all(2.0),
                        margin: EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {
                            print("You clicked text button");
                          },
                          child: Text("I am flat button"),
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 20.0,
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red[600]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                print("I am elevated button");
                              },
                              child: Text("Elevated button"),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(20.0),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 20.0)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(25, 256, 25, 25))))),
                    ),
                    Center(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              print("Elevated with icon button");
                            },
                            icon: Icon(Icons.ac_unit),
                            label: Text("Elevated with icon")))
                  ])),
              Text(
                'hello, Rinkal is here!',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Colors.grey[600],
                  fontFamily: 'IndieFlower',
                ),
              ),
              IconButton(
                onPressed: () {
                  print('you clicked icon button');
                },
                icon: Center(child: Icon(Icons.ac_unit)),
                color: Colors.amber,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.cyanAccent,
                      padding: EdgeInsets.all(50.0),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.amberAccent,
                      padding: EdgeInsets.all(50.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  )
                ],
              ),
              /*Image(
            */ /* This was from web
            image: NetworkImage(

                "https://images.ctfassets.net/kq1hxg0iw5cx/SMmVLMchPRCsBZXMwePFa/3efe7e2e3fbd2733eff1dc4ba7fc5165/banner__1_.png"),
          ),*/ /*
            image: AssetImage('assets/netflix_logo.png'),
          )*/
              Image.asset('assets/netflix_logo.png'),
              Image.network(
                  'https://images.ctfassets.net/kq1hxg0iw5cx/SMmVLMchPRCsBZXMwePFa/3efe7e2e3fbd2733eff1dc4ba7fc5165/banner__1_.png')
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[600],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const secondPage()),
            );
          },
          child: Text('click'),
        ),
      ),
    );
  }
}

class secondPage extends StatefulWidget {
  const secondPage({Key? key}) : super(key: key);

  @override
  State<secondPage> createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
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

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  late TextEditingController et1controller = new TextEditingController();
  late TextEditingController et2controller = new TextEditingController();

  String text1 = "";
  String text2 = "";
  String ans = "";

  @override
  void dispose() {
    et1controller.dispose();
    et2controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Calculator"),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                children: [
                  Text("Num1:  ( $text1 )    "),
                  Expanded(
                    child: TextField(
                      controller: et1controller,
                      onChanged: (String value) {
                        setState(() {
                          text1 = et1controller.text;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Row(
                children: [
                  Text("Num2:  ( $text2 )    "),
                  Expanded(
                      child: TextField(
                    controller: et2controller,
                    onChanged: (String value) {
                      setState(() {
                        text2 = et2controller.text;
                      });
                    },
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyanAccent),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700))),
                      onPressed: () {
                        setState(() {
                          ans =
                              (int.parse(text1) + int.parse(text2)).toString();
                        });
                      },
                      child: Text("+")),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyanAccent),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700))),
                      onPressed: () {
                        setState(() {
                          ans =
                              (int.parse(text1) - int.parse(text2)).toString();
                        });
                      },
                      child: Text("-")),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyanAccent),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700))),
                      onPressed: () {
                        setState(() {
                          ans =
                              (int.parse(text1) * int.parse(text2)).toString();
                        });
                      },
                      child: Text("*")),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.cyanAccent),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700))),
                      onPressed: () {
                        setState(() {
                          ans =
                              (int.parse(text1) / int.parse(text2)).toString();
                        });
                      },
                      child: Text("/"))
                ],
              ),
              Text(
                "ans = $ans",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )
            ]),
          ),
        ));

    /*      child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      onChanged: (String value) {
                        setState(() {
                          text = controller.text;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(text),
                  ],
                ))));*/
  }
}
