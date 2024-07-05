import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoSearch extends StatefulWidget {
  const AutoSearch({super.key});

  @override
  State<AutoSearch> createState() => _AutoSearchState();
}

class _AutoSearchState extends State<AutoSearch> {

String _message = 'Loading...' ;

@override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('level') ;
    if (value!=null) {
      setState(() {
        if (value == 'level') {
          _message = 'Auto-search sta usando il livello vero da SharedPreferences.';
        } else {
          _message = 'Nessun livello vero rilevato.';
        }
      });
      _showMessage(_message);
    } else {
      // Nessun valore in SharedPreferences, usa il valore di default
      setState(() {
        _message = 'Auto-search sta usando il valore di default.';
      });
      _showMessage(_message);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _loadValue();
              },
              child: Text('Verifica livello'),
            ),
          ],) 
      ),
      
    );
  }
}


// Pagina di prova per vedere se il widget riesce a prendere il livello vero/provvisorio che poi verra' usato per la
// ricerca automatica dei percorsi
// TODO al momento per debug c'e' un bottone da premere per far comparire un messaggio in basso con lo ScaffoldMessenger, pero' in 
// teoria ScaffoldMessenger funziona solo con i pulsanti e noi vogliamo che compaia un warning da qualche parte che dica 
// se si sta usando il valore provvisorio o meno senza usare pulsanti e se sta usando il provvisorio consiglia di usare 
// il pulsante Sync your Device del profilo.