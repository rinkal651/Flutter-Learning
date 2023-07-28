import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Fruit.dart';
import 'route_generator.dart';

void main() => runApp(const MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      /* TODO: can also define route like this
      routes: {
        '/':(_) => BasicWidgetClass(),
        '/second': (_) => SecondPage(),
        '/calc': (context) => CalculatorApp(),
        '/login': (context) => Login(ans: "13")
      },*/
    );
  }
}

class BasicWidgetClass extends StatelessWidget {
  const BasicWidgetClass({Key? key}) : super(key: key);

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
            /* Navigation first method
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const secondPage()),
            );*/
            Navigator.of(context).pushNamed('/second');
          },
          child: Text('click'),
        ),
      ),
    );
  }
}
