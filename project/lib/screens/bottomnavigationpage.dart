import 'package:flutter/material.dart';
import 'package:project/screens/autosearchPage.dart';
import 'package:project/screens/ManualSearchPage.dart'; 
import 'package:project/screens/profile.dart';
import 'package:project/screens/homepage.dart';
import 'package:project/utils/fabNotifier.dart';
import 'package:project/widgets/expandableFab.dart';
import 'package:project/widgets/actionButton.dart';


class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  //State<BottomNavigationBarPage> createState() => _HomePageState();
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBarPage> {
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
        fabStateNotifier.close(); // Chiudi il FAB quando cambia pagina
        return HomePage();
      case 1:
        fabStateNotifier.close(); // Chiudi il FAB quando cambia pagina
        return ProfilePage();
      default:
        fabStateNotifier.close(); // Chiudi il FAB quando cambia pagina
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
            _showIndex = index;
          });
        },
        currentIndex: _showIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExpandableFab(
        distance: 80,
        children: [
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AutoSearch()),
              );
            },
            icon: const Icon(Icons.auto_awesome),
            text: 'Get advice',
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManualSearch()), 
              );
            },
            icon: const Icon(Icons.travel_explore),
            text: 'Manual search',
          ),
        ],
      ),
    );
  }
}