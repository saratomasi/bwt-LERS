import 'package:flutter/material.dart';
import 'package:project/screens/questionnaire.dart'; 

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildWelcomeImage('lib/assets/welcome1.png'),
                _buildWelcomeImage('lib/assets/welcome2.png'),
                _buildWelcomeImageWithStartButton('lib/assets/welcome3.png', context),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Visibility(
                visible: _currentPage > 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Visibility(
                visible: _currentPage < 2,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
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
                Navigator.pushReplacement(
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