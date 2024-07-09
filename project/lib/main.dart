import 'package:flutter/material.dart';
import 'package:project/menu/achievements.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/splash.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/menu/TrofeiNotifier.dart';
import 'package:project/screens/bottomnavigationpage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrailState()),
        //ChangeNotifierProvider(create: (_) => TrofeiNotifier()),
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
        home: SplashScreen()
    ) ;
  }
}