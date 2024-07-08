import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/menu/TrofeiNotifier.dart';
import 'package:project/objects/trail.dart';




class AchievementsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final trofeiNotifier = Provider.of<TrofeiNotifier>(context);
    final valoriProgresso = trofeiNotifier.trofei.map((trofeo) => trofeo.progresso).toList();
    

    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Numero di colonne nella griglia
            childAspectRatio: 1, // Rapporto di aspetto dei figli
            crossAxisSpacing: 10, // Spaziatura tra le colonne
            mainAxisSpacing: 10, // Spaziatura tra le righe
          ),
          itemCount: _trofei.length,
          itemBuilder: (context, index) {
            final trofeo = _trofei[index];
            return Container(
              decoration: BoxDecoration(
                color:Color.fromARGB(255, 255, 255, 255), // Colore di sfondo
                border: Border.all(
                  color: Colors.green, // Colore del bordo
                  width: 8.0, // Spessore del bordo
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  trofeo.sbloccato ? trofeo.immagineSbloccata : trofeo.immagineNonSbloccata,
                  height: 200,
                  width: 200, 
                ),
              const SizedBox(height: 5),
              Text(
                trofeo.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                textScaler: const TextScaler.linear(2),
              ),
              const SizedBox(height: 5, width: 10),
              SizedBox(
                width: 300, //larghezza
                height: 20, //altezza
                child: LinearProgressIndicator(
                  value: trofeo.progresso,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
                ],
              ),
            );
          },
        ),
      ),
    );*/

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Welcome to the Achievements page!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 150, 45),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: trofeiNotifier.trofei.length,
                itemBuilder: (context, index) {
                  final trofeo = trofeiNotifier.trofei[index];
                  return TrofeoWidget(trofeo: trofeo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class TrofeoWidget extends StatelessWidget {
  final Trofeo trofeo;

  TrofeoWidget({required this.trofeo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            trofeo.sbloccato
                ? trofeo.immagineSbloccata
                : trofeo.immagineNonSbloccata,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 8),
          Text(
            trofeo.nome,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: trofeo.progresso,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 4),
          Text(
            '${(trofeo.progresso * 100).toStringAsFixed(0)}%',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  }


  class AchievementsProvider with ChangeNotifier {
  List<Achievement> _achievements = [];

  List<Achievement> get achievements => _achievements;

  void addAchievement(Achievement achievement) {
    _achievements.add(achievement);
    notifyListeners();
  }

  void updateAchievement(int index, double progress) {
    _achievements[index].progress = progress;
    notifyListeners();
  }

  double get totalProgress {
    if (_achievements.isEmpty) return 0;
    double total = _achievements.fold(0, (sum, item) => sum + item.progress);
    return total / _achievements.length;
  }
}

class Achievement {
  String title;
  double progress;

  Achievement({required this.title, this.progress = 0});
}