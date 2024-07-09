import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/characters.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';

class CharactersCardList extends StatelessWidget {
  final List<CharactersObject> items;

  CharactersCardList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrailState>(
      builder: (context, trailState, child) {
        List<int> percentages = updateCharacteristics(trailState.doneTrails, trailState.allTrails);
        List<int> indices = List<int>.generate(percentages.length, (index) => index);
        indices.sort((a, b) => percentages[b].compareTo(percentages[a]));
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Card(
                child: Padding(
                  padding: index == 0
                      ? const EdgeInsets.all(18.0) // Larger padding for the first card
                      : const EdgeInsets.all(8.0), // Normal padding for other cards
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          // Immagine a sinistra
                          Container(
                            width: index == 0 ? 50 : 40, // Larger image for the first card
                            height: index == 0 ? 50 : 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(items[indices[index]].imageUrl),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: index == 0 ? 50 : 60,
                          ),
                          // Testo a destra
                          Expanded(
                            child: Text(
                              items[indices[index]].text,
                              style: TextStyle(
                                fontSize: index == 0 ? 24.0 : 20.0, // Larger font size for the first card
                                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal, // Bold for the first card
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: index == 0 ? 50 : 40, // Larger size for the first CircularProgressIndicator
                                height: index == 0 ? 50 : 40,
                                child: CircularProgressIndicator(
                                  strokeWidth: index == 0 ? 6 : 5, // Adjust the stroke width if needed
                                  value: percentages[indices[index]] / 100,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                ),
                              ),
                              Text(
                                '${percentages[indices[index]].toStringAsFixed(0)}%',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    
  }
}

List<int> updateCharacteristics(List<Trail> doneTrails, List<Trail> allTrails) {
  if (doneTrails.isEmpty) {
    // Se non ci sono trail completati, restituisci una lista di default
    return [0, 0, 0, 0, 0, 0];
  }
  double totalKm = doneTrails.fold(0.0, (sum, trail) => sum + (trail.lengthKm ?? 0.0));
  double avglength = totalKm/doneTrails.length;
  List<int> percentages = [0, 0, 0, 0, 0]; // Array of counters for each type of trail (from 1 to 5)
  int kmPerc = 0;

  // Count trails by type
  for (var trail in doneTrails) {
    for (int i = 0; i < 5; i++) {
      percentages[i] += trail.percentage[i];
    }
  }
  percentages = percentages.map((psum) => (psum / doneTrails.length).round()).toList();


  if(avglength<5){
    kmPerc = 5;
  } else if(avglength<10){
    kmPerc = 10;
  } else if(avglength<15){
    kmPerc = 25;
  } else{
    kmPerc = 50;
  }

  int res = 100 - kmPerc;
  percentages = percentages.map((p) => (p*res/100).round()).toList();

  percentages.add(kmPerc);

  int sum = percentages.reduce((a, b) => a + b);
  if(sum>100){ percentages[4] -= sum-100; }
  if(sum<100){ percentages[4] += 100-sum; }

  return percentages;
}