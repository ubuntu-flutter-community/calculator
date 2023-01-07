import 'package:calculator/calculation.dart';
import 'package:calculator/calculator_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('calculate', () {
    final model = CalculatorModel();
    expect(model.history, isEmpty);

    var wasNotified = 0;
    var expectedNotified = 0;
    model.addListener(() => ++wasNotified);

    expect(model.calculate('1+2'), 3);
    expect(model.history, hasLength(1));
    expect(model.history.single, isCalculation(input: '1+2', result: 3));
    expect(wasNotified, ++expectedNotified);

    expect(model.calculate('x = 4 * 5'), 20);
    expect(model.history, hasLength(2));
    expect(model.history.first, isCalculation(input: '1+2', result: 3));
    expect(model.history.last,
        isCalculation(input: 'x = 4 * 5', variable: 'x', result: 20));
    expect(wasNotified, ++expectedNotified);

    model.clear();
    expect(model.history, isEmpty);
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
