import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Pages/AppLocalization.dart';
import 'main.dart';
import 'package:flutter/services.dart';
import 'Pages/Login.dart';
import 'Pages/SecondPage.dart';
import 'Pages/Calculator.dart';
import 'Pages/GetDataFromHttp.dart';
import 'Pages/GetDataFromFireStore.dart';
import 'Pages/ImageAnimation.dart';
import 'Pages/StateManagement.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
/*    '/':(_) => BasicWidgetClass(),
    '/second': (_) => SecondPage(),
    '/calc': (context) => CalculatorApp(),
    '/login': (context) => Login(ans: "13")*/

      case '/':
        return MaterialPageRoute(builder: (_) => BasicWidgetClass());
      case '/second':
        return MaterialPageRoute(builder: (_) => SecondPage());
      case '/calc':
        return MaterialPageRoute(builder: (context) => CalculatorApp());
      case '/login':
        if(args is String) {
          return MaterialPageRoute(builder: (context) => Login(ans: args));
        }
        return _errorRoutes();
      case '/call_http':
        return MaterialPageRoute(builder: (context) => GetDataFromHttp());
      case '/get_firestore_data':
        return MaterialPageRoute(builder: (context) => GetDataFromFireStore());
      case '/image_animation':
        return MaterialPageRoute(builder: (context) => ImageAnimation());
      case '/state_management':
        return MaterialPageRoute(builder: (context) => StateManagement());
      case '/app_localization':
        return MaterialPageRoute(builder: (context) => AppLocalization());
      default:
        print(settings.name);
        return _errorRoutes();
    }
  }
  static Route<dynamic> _errorRoutes(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ERROR"),
        ),
      ); });
  }
}
