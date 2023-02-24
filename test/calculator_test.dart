import 'package:calculator/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculate', () {
    final calculator = Calculator();
    expect(calculator.history, isEmpty);

    var wasNotified = 0;
    var expectedNotified = 0;
    calculator.addListener(() => ++wasNotified);

    expect(calculator.calculate('1+2'), 3);
    expect(calculator.history, hasLength(1));
    expect(calculator.history.single, isCalculation(input: '1+2', result: 3));
    expect(wasNotified, ++expectedNotified);

    expect(calculator.calculate('x = 4 * 5'), 20);
    expect(calculator.history, hasLength(2));
    expect(calculator.history.first, isCalculation(input: '1+2', result: 3));
    expect(calculator.history.last,
        isCalculation(input: 'x = 4 * 5', variable: 'x', result: 20));
    expect(wasNotified, ++expectedNotified);

    calculator.clear();
    expect(calculator.history, isEmpty);
    expect(wasNotified, ++expectedNotified);
  });
}

Matcher isCalculation({
  required String input,
  String? variable,
  required dynamic result,
}) {
  return isA<Calculation>()
      .having((c) => c.input, 'input', input)
      .having((c) => c.variable, 'variable', variable)
      .having((c) => c.result, 'result', result);
}
