import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/Pages/Calculator.dart';

void main() {
  testWidgets("Display Button", (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: CalculatorApp()));
    var textfield = find.byType(TextButton);
    expect(textfield, findsAtLeastNWidgets(1));
  });
}