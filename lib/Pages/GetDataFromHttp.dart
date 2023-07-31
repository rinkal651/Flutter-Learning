import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_training/model/user.dart';


class GetDataFromHttp extends StatefulWidget {
  const GetDataFromHttp({Key? key}) : super(key: key);

  @override
  State<GetDataFromHttp> createState() => _GetDataFromHttpState();
}

class _GetDataFromHttpState extends State<GetDataFromHttp> {

  List<User> users = [];

  void getData() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/todos/101');
    var response = await http.get(url);

    print(response.body);
  }

  void postData() async {
    var client = http.Client();
    var response = await client.post(
        Uri.https('jsonplaceholder.typicode.com', 'posts'),
        body: {
          "title": 'foo',
          "body": 'bar',
          "userId": '1',
        });
    print(response.body);
  }

  void fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);
      return User(
        gender: e['gender'] ?? "",
        email: e['email'] ?? "",
        state: e['state'] ?? "",
        country: e['country'] ?? "",
        postcode: e['postcode'] ?? "",
        userName: name,
      );
    }).toList();
    setState(() {
      users = transformed;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API call"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            /*
            final gender = user.gender ?? "female";
            final email = user.email ?? "ahm";
            final state = user.state ?? "gujarat";
            final postcode = user.postcode ?? "131";
            final country = user.country ?? "india";
            final color = user.gender == "male" ? Colors.yellow : Colors.greenAccent;
            final usern = user.userName.first;*/
/*            final imageurl = user['picture']['thumbnail'];*/
            final color = user.gender == "male" ? Colors.yellow : Colors
                .greenAccent;
            return ListTile(
              leading: CircleAvatar(child: Text('$index')),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: /*Image.network(imageurl))*/Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(children: [
                        Text(user.gender), Text(user.email), Text(
                            user.userName.fullName)
                      ]),
                    ))
                ]),
              ),
              tileColor: color,
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Text(">"),
          onPressed: () {
            Navigator.pushNamed(context, '/get_firestore_data');
          }),
    );
  }
}


