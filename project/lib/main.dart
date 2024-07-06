import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/splash.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/bottomnavigationpage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrailState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),

        // Animated splash screen
        home: SplashScreen() //Modificare appena il DEI ritorna a funzionare, ho fatto questa modifica solo perchè mi serviva visualizzare le schermate di welcome e questionario
    ) ;
  }
}