import 'package:flutter/material.dart';
import 'package:project/menu/TrofeiNotifier.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';
import 'package:project/widgets/gpxMap.dart';
import 'package:project/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:project/widgets/PieChart.dart';
import 'package:provider/provider.dart';
import 'package:project/menu/achi.dart';
import 'package:project/widgets/achi_progresswidget.dart';





class HomePage extends StatefulWidget {

  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}


class _HomePageState extends State<HomePage> {
  String _nome = '';
  String _avatar = '';
  String? _level = '';
  
  @override
  void initState() {
    super.initState();
    _loadValue();
    _loadUserData();
  }


  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('level') ;
    if (value!=null && value.isNotEmpty) {
      setState(() {
        _level = value ;
      });
    } else {     
      setState(() {
        _level = prefs.getString('livelloProvvisorio');
      });
    }
  }


  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _avatar = prefs.getString('avatar') ?? '';
      //_level = prefs.getString('level') ?? 'Level not found';
    });
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Card(
              child: Row(
                    children: [
                      Image.asset(
                        _getLevelIcon(_level),
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '$_nome, your level is: $_level',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ), 
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '$_nome, your level is: $_level',
                      style: const TextStyle(fontSize: 15),
                ),
              )
            ),
            SizedBox(height: 20.0),
            AchievementProgressWidget(
              title: 'Steps', 
              goal: 50000, 
              currentProgress: 35000,
            ),
            AchievementProgressWidget(
              title: 'Paths', 
              goal: 10, 
              currentProgress: 5,
            ),
            AchievementProgressWidget(
              title: 'Points of Interest', 
              goal: 10, 
              currentProgress: 3,
            ),
          ],
        ),
          )
      )
    );
  }
}


// Funzione per ottenere il percorso dell'icona in base al livello
  String _getLevelIcon(String level) {
    switch (level) {
      case 'beginner':
        return 'assets/images/beginner.png';
      case 'intermediate':
        return 'assets/images/intermediate.png';
      case 'expert':
        return 'assets/images/expert.png';
      default:
        return 'assets/images/beginner.png';  
    }
  }
