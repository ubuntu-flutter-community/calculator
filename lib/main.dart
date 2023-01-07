import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

import 'calculator_page.dart';

void main() {
  runApp(YaruTheme(
    builder: (context, yaru, child) {
      return MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        routes: const {
          Navigator.defaultRouteName: CalculatorPage.create,
        },
      );
    },
  ));
}
