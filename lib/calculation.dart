import 'package:meta/meta.dart';

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
