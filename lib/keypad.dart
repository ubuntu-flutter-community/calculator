import 'package:flutter/material.dart';

class Keypad extends StatelessWidget {
  const Keypad({
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
                  KeyButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                KeyButton.operator(
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
                  KeyButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                KeyButton.operator(
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
                  KeyButton.number(
                    onPressed: () => onInput(number),
                    label: number,
                  ),
                KeyButton.operator(
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
                KeyButton.number(
                  onPressed: () => onInput('0'),
                  label: '0',
                ),
                KeyButton.operator(
                  onPressed: () => onInput('.'),
                  label: '.',
                ),
                KeyButton.operator(
                  onPressed: () => onInput('-'),
                  label: '-',
                ),
                KeyButton(
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

enum KeyKind { number, operator }

class KeyButton extends StatelessWidget {
  const KeyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind,
  });

  const KeyButton.number({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = KeyKind.number,
  });

  const KeyButton.operator({
    super.key,
    required this.onPressed,
    required this.label,
    this.kind = KeyKind.operator,
  });

  final VoidCallback onPressed;
  final String label;
  final KeyKind? kind;

  Color? backgroundColor(BuildContext context) {
    switch (kind) {
      case KeyKind.number:
        return Theme.of(context).focusColor;
      case KeyKind.operator:
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
