import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
//import 'package:project/screens/homepage.dart';
import 'package:project/screens/login.dart';
//import 'package:project/screens/splash.dart';

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
        home: AnimatedSplashScreen(
            splash: SizedBox(
              height: 100, width: 100,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/assets/leaf.png'),
                      //SizedBox(height:100,width:100),  -> serve per lasciare eventualmente spazio tra immagine e text: aggiunge un box bianco
                      Text(
                        'Splash Screen',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ]),
            ),

            duration: 3000,
            splashTransition:
                SplashTransition.fadeTransition, // per cambiare la transizione
            backgroundColor: Colors.white, // per cambiare il colore sfondo
            nextScreen: LoginPage()));
            //TODO FARE IN MODO CHE LE CREDENZIALI VENGANO SALVATE E SI ENTRI SUBITO IN HOME
  }
}
