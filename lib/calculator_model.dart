import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculation.dart';

class CalculatorModel extends ChangeNotifier {
  var _context = ContextModel();
  final _history = <Calculation>[];

  List<Calculation> get history => List.unmodifiable(_history);

  dynamic calculate(String input) {
    final assignment = RegExp(r'(\w+)\s*=(.+)').firstMatch(input);
    if (assignment != null) {
      final variable = assignment.group(1)!;
      final result = calculate(assignment.group(2)!);
      _context.bindVariableName(variable, Number(result));
      _history[_history.length - 1] = _history.last.copyWith(
        input: input,
        variable: variable,
      );
      return result;
    }
    final parser = Parser();
    final expression = parser.parse(input);
    final result = expression.evaluate(EvaluationType.REAL, _context);
    _history.add(Calculation(input: input, result: result));
    notifyListeners();
    return result;
  }

  void clear() {
    _history.clear();
    _context = ContextModel();
    notifyListeners();
  }
}
