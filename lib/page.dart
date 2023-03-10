import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'calculator.dart';
import 'keypad.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void calculate(String input) {
    final calculator = context.read<Calculator>();
    try {
      final result = formatResult(calculator.calculate(input));
      _controller.value = TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(offset: result.length),
      );
    } catch (e) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text('$e'),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );
    } finally {
      _focusNode.requestFocus();
    }
  }

  String formatResult(dynamic number) {
    final pattern = NumberFormat.decimalPattern();
    pattern.maximumFractionDigits = 10;
    return pattern.format(number);
  }

  void insertText(String text) {
    _controller.value = _controller.value.replaced(_controller.selection, text);
  }

  void selectCalculation(Calculation calculation) {
    _controller.value = TextEditingValue(
      text: calculation.input,
      selection: TextSelection.collapsed(offset: calculation.input.length),
    );
    _focusNode.requestFocus();
  }

  void resetCalculator() {
    _controller.clear();
    _focusNode.requestFocus();
    context.read<Calculator>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final history = context.select((Calculator m) => m.history);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final calculation = history[index];
                return ListTile(
                  title: Text(calculation.input),
                  trailing: Text(
                    formatResult(calculation.result),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  onTap: () => selectCalculation(calculation),
                );
              },
            ),
          ),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: TextField(
                        autofocus: true,
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: history.isEmpty ? 'x = 1 + 1' : null,
                        ),
                        onSubmitted: calculate,
                      ),
                    ),
                  ),
                  KeyButton.operator(
                    onPressed: resetCalculator,
                    label: 'C',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2),
              child: Keypad(
                onInput: insertText,
                onDone: () => calculate(_controller.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
