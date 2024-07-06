import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/trailPage.dart';

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
    var trailState = context.watch<TrailState>();

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
          Expanded(flex: 3, child: sessionList(trailState),), 
        ],
      )),
    );
  }

  Widget sessionList(TrailState trailState) {
    var undoneTrails = trailState.doneTrails;
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: undoneTrails.length,
      itemBuilder: (context, index) {
        Trail tmp = undoneTrails[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('${tmp.name}'),
            subtitle: Text('${tmp.date.toLocal()}'.split(' ')[0]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              var updatedTrail = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrailPage(trail: tmp)),
              );
              // Aggiorna undoneTrails se il trail è stato modificato
              if (updatedTrail != null) {
                setState(() {
                  trailState.updateTrail(updatedTrail);
                });
              }
            }
          ),
        );
      },
    );
  }
}


//TODO fare in modo che i percorsi suggeriti siano solo quelli del livello corretto