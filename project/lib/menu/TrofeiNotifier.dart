import 'package:flutter/material.dart';
import 'package:project/providers/dataprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/steps.dart';


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
  final TipoTrofeo tipo;
  final int target;
  final String immagineSbloccata;
  final String immagineNonSbloccata;
  bool sbloccato;
  double progresso;

  Trofeo({
    required this.nome,
    required this.tipo,
    required this.target,
    required this.immagineSbloccata,
    required this.immagineNonSbloccata,
    this.sbloccato = false,
    this.progresso = 0.0,
  });
}

enum TipoTrofeo {steps, paths, poi, level}

class TrofeiNotifier with ChangeNotifier  {
  final List<Trofeo> _trofei = [
    Trofeo(
      nome: '100 000 steps!',
      tipo: TipoTrofeo.steps,
      target: 100000,
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
    ),
    Trofeo(
      nome: '10 paths done!',
      tipo: TipoTrofeo.paths,
      target: 10,
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
    ),
    Trofeo(
      nome: '20 points of interest visited!',
      tipo: TipoTrofeo.poi,
      target: 10,
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
    ),
    Trofeo(
      nome: 'Congratualtions! You moved to the next level',
      tipo: TipoTrofeo.level,
      target: 1,
      immagineSbloccata: 'lib/assets/trophy.png',
      immagineNonSbloccata: 'lib/assets/trophy_locked.png',
    ),
    
  ];

  

  List<Trofeo> get trofei => _trofei;

  void sbloccaTrofeo(String nomeTrofeo, BuildContext context) {
    for (var trofeo in trofei) {
      if (trofeo.nome == nomeTrofeo && !trofeo.sbloccato) {
        trofeo.sbloccato = true;
        notifyListeners();
        _mostraDialogoCongratulazioni(context, trofeo.nome);
      }
    }
  }

  void _mostraDialogoCongratulazioni(BuildContext context, String nomeTrofeo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You have a new trophy unloacked: $nomeTrofeo'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void aggiornaProgresso(String nomeTrofeo, double progresso) {
    for (var trofeo in _trofei) {
      if (trofeo.nome == nomeTrofeo) {
        trofeo.progresso = progresso;
        notifyListeners();
      }
    }
  }
/*
  // Funzione per verificare e sbloccare i trofei in base ai progressi dell'utente
  void verificaObiettivi(BuildContext context) {
    final datiUtente = Provider.of<DataProvider>(context, listen: false);
    int steps = datiUtente.steps.length;
    
    

    if (steps >= 100000) {
      sbloccaTrofeo('100 000 steps!', context);
    }
    if (datiUtente.paths >= 10) {
      sbloccaTrofeo('10 paths done!', context);
    }
    if (datiUtente.poi >= 20) {
      sbloccaTrofeo('20 points of interest visited!', context);
    }
    // Esempio di come verificare e sbloccare il trofeo del livello
    // In realtà questo dipende da come è implementato il sistema di livelli
    // e come si gestisce il progresso tra i livelli.
    if (datiUtente.level == 'Intermediate') {
      sbloccaTrofeo('Congratulations! You moved to the next level', context);
    }*/
}


  



/*
void verificaObiettivi(
  TrofeiNotifier trofeiNotifier, 
  int steps, 
  int paths,
  int poi,
  String level,
  BuildContext context) {
  
  
  if (steps >= 100000) {
    trofeiNotifier.sbloccaTrofeo('100 000 steps!', context);
  }
  if (paths >= 10) {
    trofeiNotifier.sbloccaTrofeo('10 paths done!', context);
  }
  if (poi >= 20) {
    trofeiNotifier.sbloccaTrofeo('10 points of interest visited!', context);
  }
  /*
  if (paths >= 10) {
    trofeiNotifier.sbloccaTrofeo('10 paths done!', context);
  }*/ // ci dovrebbe essere quello che sblocca il livello
  

  double progresso100milaPassi = steps / 100000;

  trofeiNotifier.aggiornaProgresso('100 000 steps!', progresso100milaPassi);


  

}*/

