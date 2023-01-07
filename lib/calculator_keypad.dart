import 'package:flutter/material.dart';

class CalculatorKeypad extends StatelessWidget {
  const CalculatorKeypad({
    super.key,
    required this.onInput,
    required this.onDone,
  });

  final ValueChanged<String> onInput;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return TextFieldTapRegion(
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final number in ['7', '8', '9'])
                  CalculatorButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                CalculatorButton.operator(
                  onPressed: () => onInput('/'),
                  label: '/',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final number in ['4', '5', '6'])
                  CalculatorButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                CalculatorButton.operator(
                  onPressed: () => onInput('*'),
                  label: '*',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final number in ['1', '2', '3'])
                  CalculatorButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                CalculatorButton.operator(
                  onPressed: () => onInput('+'),
                  label: '+',
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalculatorButton.number(
                  onPressed: () => onInput('0'),
                  label: '0',
                ),
                CalculatorButton.operator(
                  onPressed: () => onInput('.'),
                  label: '.',
                ),
                CalculatorButton.operator(
                  onPressed: () => onInput('-'),
                  label: '-',
                ),
                CalculatorButton(
                  onPressed: onDone,
                  label: '=',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum CalculatorButtonKind { number, operator }

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind,
  });

  const CalculatorButton.number({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = CalculatorButtonKind.number,
  });

  const CalculatorButton.operator({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = CalculatorButtonKind.operator,
  });

  final VoidCallback onPressed;
  final String label;
  final CalculatorButtonKind? kind;

  Color? backgroundColor(BuildContext context) {
    switch (kind) {
      case CalculatorButtonKind.number:
        return Theme.of(context).focusColor;
      case CalculatorButtonKind.operator:
        return Theme.of(context).hoverColor;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor(context),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
