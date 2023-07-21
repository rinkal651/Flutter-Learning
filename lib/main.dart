import 'package:flutter/material.dart';

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
        body: Center(
            child: Column(children: <Widget>[
          Text(
            'hello, ninjas!',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey[600],
              fontFamily: 'IndieFlower',
            ),
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
          onPressed: () {},
          child: Text('click'),
        ),
      ),
    );
  }
}
