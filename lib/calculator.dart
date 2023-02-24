import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends ChangeNotifier {
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

@immutable
class Calculation {
  const Calculation({
    required this.input,
    this.variable,
    required this.result,
  });

  final String input;
  final String? variable;
  final dynamic result;

  Calculation copyWith({
    String? input,
    String? variable,
    dynamic result,
  }) {
    return Calculation(
      input: input ?? this.input,
      variable: variable ?? this.variable,
      result: result ?? this.result,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Calculation &&
        other.input == input &&
        other.variable == variable &&
        other.result == result;
  }

  @override
  int get hashCode => Object.hash(input, variable, result);

  @override
  String toString() {
    return 'Calculation(input: $input, variable: $variable, result: $result)';
  }
}
