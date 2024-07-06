import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoSearch extends StatefulWidget {
  const AutoSearch({super.key});

  @override
  State<AutoSearch> createState() => _AutoSearchState();
}

class _AutoSearchState extends State<AutoSearch> {
  String _message = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<String?> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('level');
    if (value != null) {
      setState(() {
       // if (value == 'level') {
          _message =
              'Our advice is currently based on biometrical data coming from your device. If you are looking for something different, you could try to check the "Manual search" page.';
        // }  else {
        //   _message = 'Nessun livello vero rilevato.';
        // }
      });
      // _showMessage(_message);
    } else {
      // Nessun valore in SharedPreferences, usa il valore di default
      setState(() {
        value = prefs.getString('livelloProvvisorio') ;
        _message = 'Our advice is currently based only on your answers to the questionnaire. If you are looking for more accurate suggestions, go to the "Profile" page and tap on "Sync your device".';
        
      });
      // _showMessage(_message);
    }
    return value ;
  }

  // void _showMessage(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Advice!'),
        backgroundColor: Colors.green.shade100,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 500,
            height: 100,
            child: Card(
              color: Colors.amber.shade100,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(_message)),)
            ), 
          
          // ElevatedButton(
          //   onPressed: () {
          //     _loadValue();
          //   },
          //   child: Text('Verifica livello'),
          // ),
        ],
      )),
    );
  }
}


// Pagina di prova per vedere se il widget riesce a prendere il livello vero/provvisorio che poi verra' usato per la
// ricerca automatica dei percorsi
// TODO al momento per debug c'e' un bottone da premere per far comparire un messaggio in basso con lo ScaffoldMessenger, pero' in 
// teoria ScaffoldMessenger funziona solo con i pulsanti e noi vogliamo che compaia un warning da qualche parte che dica 
// se si sta usando il valore provvisorio o meno senza usare pulsanti e se sta usando il provvisorio consiglia di usare 
// il pulsante Sync your Device del profilo.