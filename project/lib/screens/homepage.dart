import 'package:flutter/material.dart';
import 'package:project/database/missions_database.dart';
import 'package:project/screens/missionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';
import 'package:project/menu/trophiespage.dart';
import 'package:project/objects/characters.dart' ;
import 'package:project/utils/fabNotifier.dart';
import 'package:project/widgets/characterList.dart';


class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = '';
  String _avatar = '';
  String _value = '';
  

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadValue() ;
    fabStateNotifier.close();
  }

  @override
  void dispose() {
    fabStateNotifier.close(); // Chiudi il FAB quando la pagina viene distrutta
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _avatar = prefs.getString('avatar') ?? '';
      //_level = prefs.getString('level') ?? '';
    });
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('level');
    if (value != null && value.isNotEmpty) {
      setState(() {
        _value = value ;
      });
    } else {
      // Nessun valore in SharedPreferences, usa il valore di default
      setState(() {
        _value = prefs.getString('livelloProvvisorio')!;
      });
    }
    print('Loaded value: $_value'); // Debug
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.green.shade100,
        title: Row(
          children: [
            if (_avatar.isNotEmpty)
              CircleAvatar(
                backgroundImage: AssetImage(_avatar),
              ),
            SizedBox(width: 10),
            Text(_nome.isNotEmpty ? _nome : 'Home Page'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                fabStateNotifier.close();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrophiesPage()));
              },
              child: const ListTile(
                  leading: Icon(Icons.star), title: Text('Achievements')),
            ),
            ElevatedButton(
              onPressed: () {
                fabStateNotifier.close();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              child: const ListTile(
                  leading: Icon(Icons.favorite), title: Text('Favorites')),
            ),
            ElevatedButton(
              onPressed: () {
                fabStateNotifier.close();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExploreLater()));
              },
              child: ListTile(
                  leading: Icon(Icons.alarm), title: Text('Explore later')),
            ),
            ElevatedButton(
              onPressed: () {
                fabStateNotifier.close();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sessions()));
              },
              child: ListTile(
                  leading: Icon(Icons.run_circle_outlined),
                  title: Text('Sessions') //database delle sessioni
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fabStateNotifier.close();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MissionPage(missionIds: missionsDatabase.keys.toList(),)));
              },
              child: ListTile(
                  leading: Icon(Icons.explore),
                  title: Text('Missions') //database delle sessioni
              ),
            ),
          ],
        ),
      ),
      body: Column(
      verticalDirection: VerticalDirection.down,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
            'Welcome!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
            )
          ),
          Center(
            child: SizedBox(
              width: 500,
              height: 70,
              child: Card(
                color: Colors.green.shade100,
                child: Center(
                  child: Text(
                    '$_nome, your level is: $_value',
                    style: const TextStyle(fontSize: 20), 
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(child: CharactersListBuilder()) 
        ],
      )

    );
  }
}

class CharactersListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<CharactersObject> items = [
      CharactersObject(
        imageUrl: 'lib/assets/naturalist.png',
        text: 'Wilderness Explorer',
      ),
      CharactersObject(
        imageUrl: 'lib/assets/historian.png',
        text: 'Time Voyager',
      ),
      CharactersObject(
        imageUrl: 'lib/assets/artist.png',
        text: 'Artistic Alchemist',
      ),
      CharactersObject(
        imageUrl: 'lib/assets/food.png',
        text: 'Gastronomic Guru',
      ),
      CharactersObject(
        imageUrl: 'lib/assets/local.png',
        text: 'Padovano DOC',
      ),
      CharactersObject(
        imageUrl: 'lib/assets/walker.png',
        text: 'Joyful Wanderer',
      ),
    ];

    return CharactersCardList(items: items);
  }
}