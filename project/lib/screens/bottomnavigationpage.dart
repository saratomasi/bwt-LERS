import 'package:flutter/material.dart';
import 'package:project/screens/profile.dart';
import 'package:project/screens/homepage.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNavigationBarPage> {
  int _showIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _showIndex = index;
    });
  }

  List<Widget> screenList = const [
    HomePage(),
    ProfilePage(),
  ];

 Widget _showPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return ProfilePage();
      default:
        return HomePage();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showPage(index: _showIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
           _showIndex = index ;
          });
        },
        currentIndex: _showIndex,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        
        //aggiungere bottone nuova sessione
      ]),
      //floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //tooltip: 'Increment',
        //child: const Icon(Icons.add),
      //),
    );
  }
}
