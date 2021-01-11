import 'package:clima/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ClimaApp());
}

class ClimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Band Staff Weather',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}