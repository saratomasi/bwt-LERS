import 'package:flutter/material.dart';
import 'package:project/menu/achievements.dart';
import 'package:project/menu/explorelater.dart';
import 'package:project/menu/favorites.dart';
import 'package:project/menu/sessions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/widgets/PieChart.dart';



class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = '';
  String _avatar = '';
  String _frequenzaAllenamento = '';
  

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = prefs.getString('nome') ?? '';
      _avatar = prefs.getString('avatar') ?? '';
      _frequenzaAllenamento = prefs.getString('frequenzaAllenamento') ?? '';
    });
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrofeiNotifier()));
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
        child: Column(
        verticalDirection: VerticalDirection.down,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
              'Benvenut*!',
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
                      '$_nome, il tuo livello è: $_frequenzaAllenamento',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 200,
              child: PieChartWidget(),
              alignment: Alignment.center,
            ) 
          ],
        ),
      )

    );
  }
}
