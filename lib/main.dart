import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'Fruit.dart';
import 'route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.crash();
  runApp(const MaterialApp(
    home: GetDataFromFireStore(),
  ));
}

class GetDataFromFireStore extends StatefulWidget {
  const GetDataFromFireStore({Key? key}) : super(key: key);

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('User');

  logCrash() async{
    FirebaseCrashlytics.instance.setCustomKey('custom_key', 'value');
    await FirebaseCrashlytics.instance.recordError(
        Error(),
        null,
        reason: 'Custom error',
        // Pass in 'fatal' argument
        fatal: true
    );
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: logCrash, child: Text("Crash log")),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String city = _cityController.text;
                    if (city != null) {
                      await _users.add({"name": name, "City": city});

                      _nameController.text = '';
                      _cityController.text = '';
                      FirebaseAnalytics.instance.logEvent(name: 'Add user');
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _cityController.text = documentSnapshot['City'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String city = _cityController.text;
                    if (city != null) {
                      await _users
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "City": city});
                      _nameController.text = '';
                      _cityController.text = '';
                      FirebaseAnalytics.instance.logEvent(name: 'Update user');
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _users.doc(productId).delete();

    FirebaseAnalytics.instance.logEvent(name: 'Delete user');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        body: StreamBuilder(
          stream: _users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['City'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

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
