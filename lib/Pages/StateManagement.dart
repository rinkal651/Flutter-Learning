import 'package:flutter/material.dart';

class StateManagement extends StatelessWidget {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    /* TODO: Stateful widget
    return StatefulBuilder(builder: (context, StateSetter setState) => Scaffold(
      body: Text('$_count'),

      floatingActionButton: FloatingActionButton(onPressed: ()=> setState(()=>_count++),
      child: Text("+"),),
    ));*/
    return Scaffold(
      appBar:AppBar(title: Text("State Management"),),
      body: InheritedCounter( child: MyHomePage3() ), // <-- make sure your InheritedWidget wraps the widgets that use its data
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/second');
      },),
    );
  }
}
// The InheritedWidget
class InheritedCounter extends InheritedWidget {
  final Map _counter = { 'val': 0 };  // Data structure is a map because InheritedWidgets are immutable
  final Widget child;

  InheritedCounter({ required this.child }) : super(child: child);

  increment() {
    _counter['val']++;
  }

  get counter => _counter['val'];

  @override
  bool updateShouldNotify(InheritedCounter oldWidget) => true;

}



class MyHomePage3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {


          return Scaffold(

          );
        }
    );
  }
}