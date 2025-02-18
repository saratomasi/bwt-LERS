import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/bottomnavigationpage.dart';
import 'package:project/screens/login.dart';
import 'package:project/utils/impact.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    return AnimatedSplashScreen.withScreenFunction(
            splash: SizedBox(
              height: 200, width: 200,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Image.asset(
                          'lib/assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],),
            ),
            duration: 3000,
            splashTransition:
                SplashTransition.fadeTransition, // per cambiare la transizione
            backgroundColor: Colors.green.shade100, // per cambiare il colore sfondo
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