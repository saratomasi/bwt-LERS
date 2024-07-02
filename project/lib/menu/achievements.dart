import 'package:flutter/material.dart';

/*
class Achievements extends StatelessWidget {
   Achievements({super.key});


  final List<String> entries = <String>['1st path!', '5 paths', '10 paths', '15 paths', '20 paths', 
  '25 paths', '30 paths', '35 paths', '40 paths', '45 paths', '50 paths', '70 paths', '100 paths', 
  '200 paths', '500 paths'];
  final List<int> colorCodes = <int>[100, 500, 100, 500, 100, 500, 100, 500, 100, 500, 100, 500, 100, 500, 100];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.green[colorCodes[index]],
          child: Center(child: Text(' ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
  }

  */
  class Trofeo {
  final String nome;
  final String immagineSbloccata;
  final String immagineNonSbloccata;
  bool sbloccato;
  double progresso;

  Trofeo({
    required this.nome,
    required this.immagineSbloccata,
    required this.immagineNonSbloccata,
    this.sbloccato = false,
    this.progresso = 0.0,
  });
}

class TrofeiNotifier extends StatelessWidget with ChangeNotifier  {
  final List<Trofeo> trofei = [
    Trofeo(
      nome: '10000 steps!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      sbloccato: false,
    ),
    Trofeo(
      nome: '25000 steps!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '50000 steps!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '75000 steps!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '100000 steps!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    /*Trofeo(
      nome: '30 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '50 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '100 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),*/
  ];

  
  Widget build(BuildContext context) {
    return Scaffold(
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
          itemCount: trofei.length,
          itemBuilder: (context, index) {
            final trofeo = trofei[index];
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
                textScaler: const TextScaler.linear(3),
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
    );
  }

  List<Trofeo> get trofeii => trofei;

  void sbloccaTrofeo(String nomeTrofeo) {
    for (var trofeo in trofei) {
      if (trofeo.nome == nomeTrofeo && !trofeo.sbloccato) {
        trofeo.sbloccato = true;
        notifyListeners();
      }
    }
  }

  void aggiornaProgresso(String nomeTrofeo, double progresso) {
    for (var trofeo in trofei) {
      if (trofeo.nome == nomeTrofeo) {
        trofeo.progresso = progresso;
        notifyListeners();
      }
    }
  }
}

void verificaObiettivi(TrofeiNotifier trofeiNotifier, int steps) {
  if (steps >= 10000) {
    trofeiNotifier.sbloccaTrofeo('10000 steps!');
  }
  if (steps >= 25000) {
    trofeiNotifier.sbloccaTrofeo('25000 steps!');
  }
  if (steps >= 50000) {
    trofeiNotifier.sbloccaTrofeo('50000 steps!');
  }
  if (steps >= 75000) {
    trofeiNotifier.sbloccaTrofeo('75000 steps!');
  }
  if (steps >= 100000) {
    trofeiNotifier.sbloccaTrofeo('100000 steps!');
  }
}

