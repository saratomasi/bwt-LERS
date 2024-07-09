import 'package:flutter/material.dart';
import 'package:project/menu/achievements.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';
import 'package:project/widgets/characterList.dart';
import 'package:project/objects/characters.dart' ;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/widgets/PieChart.dart';
import 'package:project/menu/achievements.dart';
import 'package:project/widgets/achi_progresswidget.dart';
import 'package:project/menu/trophiesnotifier.dart';



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

    //final int steps = Provider.of<DataProvider>(context);

    // notifier per gestire i trofei
    //final trofeiNotifier = Provider.of<TrofeiNotifier>(context);
    // Verifica e aggiorna i trofei in base al numero di passi
    //verificaObiettivi(trofeiNotifier, steps,  context);
    // Ottieni i valori di progresso per il grafico
    //final valoriProgresso = trofeiNotifier.trofei.map((trofeo) => trofeo.progresso).toList();

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AchievementsPage()));
              },
              child: const ListTile(
                  leading: Icon(Icons.star), title: Text('Achievements')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              child: const ListTile(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sessions()));
              },
              child: ListTile(
                  leading: Icon(Icons.run_circle_outlined),
                  title: Text('Sessions') //database delle sessioni
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