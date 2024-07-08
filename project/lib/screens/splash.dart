import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/bottomnavigationpage.dart';
import 'package:project/screens/login.dart';
import 'package:project/utils/impact.dart';
//import 'package:project/screens/welcome.dart'; // DA TOGLIERE QUANDO SERVER OK

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return AnimatedSplashScreen.withScreenFunction(
    //return AnimatedSplashScreen( // DA TOGLIERE QUANDO SERVER OK
            splash: SizedBox(
              height: 100, width: 100,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/assets/logo.png'),
                      //SizedBox(height:100,width:100),  -> serve per lasciare eventualmente spazio tra immagine e text: aggiunge un box bianco
                    ]),
            ),

            duration: 3000,
            splashTransition:
                SplashTransition.fadeTransition, // per cambiare la transizione
            backgroundColor: Colors.white, // per cambiare il colore sfondo
            screenFunction:  () async {return checkLogin(context) ; } );
            //nextScreen: WelcomePage()) ; // DA TOGLIERE QUANDO SERVER OK
  }    
  

  Future<Widget> checkLogin(BuildContext context) async {
    final result = await Impact().refreshTokens();
    if (result == 200) {
      return BottomNavigationBarPage() ;
    } else {
      return LoginPage() ;
    }
  } 
}