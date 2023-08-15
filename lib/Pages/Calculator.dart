import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  int add(int a, int b) {
    return (a+b);
  }

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
                        ans = (new CalculatorApp().add(int.parse(text1),int.parse(text2))).toString();
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
                        ans = (int.parse(text1) - int.parse(text2)).toString();
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
                        ans = (int.parse(text1) * int.parse(text2)).toString();
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
                        ans = (int.parse(text1) / int.parse(text2)).toString();
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login',
              arguments: "Calc answer is $ans");
        },
        child: Text("Login", maxLines: 1),
      ),
    );

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
