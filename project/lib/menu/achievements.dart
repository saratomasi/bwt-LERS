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

  Trofeo({
    required this.nome,
    required this.immagineSbloccata,
    required this.immagineNonSbloccata,
    this.sbloccato = false,
  });
}

class Achievements extends StatelessWidget {
  final List<Trofeo> trofei = [
    Trofeo(
      nome: '1st path!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      sbloccato: true,
    ),
    Trofeo(
      nome: '5 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '10 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '15 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
      nome: '20 paths!',
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
      //sbloccato: true,
    ),
    Trofeo(
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
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
        color: Color.fromARGB(255, 255, 255, 255), // Colore di sfondo
        border: Border.all(
          color: Colors.green, // Colore del bordo
          width: 4.0, // Spessore del bordo
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            trofeo.sbloccato ? trofeo.immagineSbloccata : trofeo.immagineNonSbloccata,
            height: 100,
            width: 100, 
          ),
          SizedBox(height: 8),
          Text(
            trofeo.nome,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
            );
          },
        ),
      ),
    );
  }
}

/*
void main() {
  runApp(MaterialApp(
    home: Achievements(),
  ));
} */
