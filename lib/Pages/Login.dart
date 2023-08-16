import 'package:flutter/material.dart';
import 'AutocompleteExample.dart';
import 'SharedPreferencesData.dart';

class Login extends StatefulWidget {
  final String ans;

  const Login({Key? key, required this.ans}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];
  String _gender = "";
  bool _isCheckBoxChecked = false;

  saveUserNameToSharedPref(String email) async
  {
    await SharedPreferencesData.init();
    await SharedPreferencesData.setUsername(email);
  }

  @override
  Widget build(BuildContext context) {
    //In scafflod we can not set image as background but in container we can set image as background

    return Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  opacity: 1.0,
                  image: AssetImage('assets/login.jpg'),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 35, top: 130),
                      child: Text(
                        "Welcome \n Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 33.0,
                        ),
                      )),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          right: 35,
                          left: 35),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _formKey.currentState!.validate();
                                  saveUserNameToSharedPref(value.toString());
                                },
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    fillColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0))),
                              ),
                              SizedBox(height: 30.0),
                              AutocompleteExample(),
                              SizedBox(height: 30.0),

                              SizedBox(height: 30.0),
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: _isCheckBoxChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isCheckBoxChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text('Settings'),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    fillColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0))),
                              ),
                              TextButton(onPressed: () {
                                Navigator.pushNamed(context, '/call_http');
                              }, child: Text("Call http")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}