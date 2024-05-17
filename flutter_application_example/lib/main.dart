import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// comme cambio commento
// commento prova

// prova con branch 
// prova 2 con branch

// prova 3

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

