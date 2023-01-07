import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'calculation.dart';
import 'calculator_model.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorModel(),
      child: const CalculatorPage(),
    );
  }

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
    final model = context.read<CalculatorModel>();
    try {
      final result = formatResult(model.calculate(input));
      _controller.value = TextEditingValue(
        text: result,
        selection: TextSelection.collapsed(offset: result.length),
      );
    } catch (e) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentMaterialBanner();
      messenger.showMaterialBanner(
        MaterialBanner(
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text('OK'),
            ),
          ],
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
    context.read<CalculatorModel>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final history = context.select((CalculatorModel m) => m.history);
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
                    style: Theme.of(context).textTheme.headline6!,
                  ),
                  onTap: () => selectCalculation(calculation),
                );
              },
            ),
          ),
          TextField(
            autofocus: true,
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: history.isEmpty ? 'x = 1 + 1' : null,
              suffixIcon: YaruIconButton(
                onPressed: resetCalculator,
                icon: const Icon(YaruIcons.edit_clear),
              ),
            ),
            onSubmitted: calculate,
          ),
        ],
      ),
    );
  }
}
