import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/Pages/Calculator.dart';

void main() {
  CalculatorApp? calc;
  //run before some test gives error Non-nullable variable 'calc' must be assigned before it can be used.
 /* setUp(() => calc = CalculatorApp());*/

  //run before all test
  setUpAll(() => calc = CalculatorApp());

  //Run after some test
  tearDown(() => null);

  //Run after all test
  tearDownAll(() => null);
  group('I want to test my calc', () {
    test('I want to test addition', () {

      int? result = calc?.add(3,3);
      //step 3
      expect(result, 6);
      expect(result, isNot(10));
    }
    );});

  tearDownAll(() => print("We are done"));
}