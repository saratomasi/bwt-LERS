import 'package:flutter/material.dart';
import 'package:project/widgets/trailCard.dart';
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
  String? _value;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('level');
    if (value != null && value.isNotEmpty) {
      setState(() {
        _value = value ;
        _message =
            'Our advice is currently based on biometrical data coming from your device. If you are looking for something different, you could try to check the "Manual search" page.';
      });
    } else {
      // Nessun valore in SharedPreferences, usa il valore di default
      setState(() {
        _value = prefs.getString('livelloProvvisorio');
        _message =
            'Our advice is currently based only on your answers to the questionnaire. If you are looking for more accurate suggestions, go to the "Profile" page and tap on "Sync your device".';
      });
    }
    print('Loaded value: $_value'); // Debug
  }

   List<Trail> _filterTrails(List<Trail> trails) {
    if (_value == null) return [];

    return trails.where((trail) {
      String levelText = trail.getTrailLevelText(); // Ottiene il testo del livello
      print('Trail level text: $levelText');
      var trailLevel;
      if (_value=='Beginner') {
        trailLevel = 'Easy' ;
      } else if (_value=='Intermediate') {
        trailLevel = 'Intermediate' ;
      } else {
        trailLevel = 'Difficult' ;
      }
      return levelText == trailLevel;
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    var trailState = context.watch<TrailState>();

    var filteredTrails = _filterTrails(trailState.notDoneTrails);

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
              height: 110,
              child: Card(
                color: Colors.amber.shade100,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(_message,
                  style: TextStyle(fontSize: 16.0)),
                  
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: autosearchList(trailState),
            ),
          ],
        ),
      ),
    );
  }

Widget autosearchList(TrailState trailState) {
var filteredTrails = _filterTrails(trailState.notDoneTrails);
if (filteredTrails.isEmpty) {
      return Center(
        child: Text(
          'No trails available.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: filteredTrails.length,
      itemBuilder: (context, index) {
        print('1 , ${filteredTrails[index].name}, ${index}');
        Trail tmp = filteredTrails[index];
        print('2 ${tmp.name}');
        return Consumer<TrailState>(
          builder: (context, trailState, child){
            return TrailCard(
              key: ValueKey(filteredTrails[index].id),
              trail: filteredTrails[index],
              onToggle: () async {
                setState(() {});
              },
            );});
      }
    );
  }


}

