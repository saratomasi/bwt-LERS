import 'package:flutter/material.dart';
import 'package:project/screens/profile.dart';
import 'package:project/menu/achievements.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Achievements()));
            },
            child: ListTile(
                leading: Icon(Icons.star), title: Text('Achievements')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favorites()));
            },
            child: ListTile(
                leading: Icon(Icons.favorite), title: Text('Favorites')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreLater()));
            },
            child: ListTile(
                leading: Icon(Icons.alarm), title: Text('Explore later')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Sessions()));
            },
            child: ListTile(
                leading: Icon(Icons.run_circle_outlined),
                title: Text('Sessions') //database delle sessioni
                ),
          )
        ]),
      ),
      
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
