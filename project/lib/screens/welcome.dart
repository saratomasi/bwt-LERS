import 'package:flutter/material.dart';
import 'package:project/screens/questionnaire.dart'; // Assicurati di importare la pagina del questionario

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          children: [
            _buildWelcomeImage('lib/assets/welcome1.png'),
            _buildWelcomeImage('lib/assets/welcome2.png'),
            _buildWelcomeImageWithStartButton('lib/assets/welcome3.png', context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeImage(String imagePath) {
    return Center(
      child: Image.asset(imagePath, fit: BoxFit.contain),
    );
  }

  Widget _buildWelcomeImageWithStartButton(String imagePath, BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Questionnaire()),
                );
              },
              child: Text('Start'),
            ),
          ),
        ),
      ],
    );
  }
}