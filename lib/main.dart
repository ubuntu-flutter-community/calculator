import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'calculator_page.dart';

void main() {
  runApp(YaruTheme(
    builder: (context, yaru, child) => MaterialApp(
      theme: yaru.theme,
      darkTheme: yaru.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        appBar: const YaruWindowTitleBar(
          title: Text('Calculator'),
        ),
        body: child,
      ),
      routes: const {
        Navigator.defaultRouteName: CalculatorPage.create,
      },
    ),
  ));
}
