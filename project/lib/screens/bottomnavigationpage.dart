import 'package:flutter/material.dart';
import 'package:project/screens/profile.dart';
import 'package:project/screens/homepage.dart';
import 'package:project/widgets/expandableFab.dart';
import 'package:project/widgets/actionButton.dart';

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

//x button che si espande:
  static const _actionTitles = ['AI advice!', 'Search page'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExpandableFab(
        distance: 80,
        children: [
          ActionButton(onPressed: () => _showAction(context, 0), icon: const Icon(Icons.auto_awesome),text: 'Get advice'),
          ActionButton(onPressed: () => _showAction(context, 1), icon: const Icon(Icons.travel_explore),text: 'Manual search'),
        ],
      ),
      //floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //tooltip: 'Increment',
        //child: const Icon(Icons.add),
      //),
    );
  }
}
