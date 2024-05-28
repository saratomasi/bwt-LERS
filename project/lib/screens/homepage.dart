import 'package:flutter/material.dart';
import 'package:project/menu/achievements.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

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
    );
  }
}






