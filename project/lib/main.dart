import 'package:flutter/material.dart';
import 'package:project/screens/homepage.dart';
import 'package:project/screens/splash.dart';
import 'package:project/screens/bottomnavigationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // Animated splash screen
        home: SplashScreen() 
    ) ;
  }
}
