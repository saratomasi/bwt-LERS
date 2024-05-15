import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// comme

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //commento inutile

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

