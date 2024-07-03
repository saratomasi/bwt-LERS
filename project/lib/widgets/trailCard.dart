import 'package:flutter/material.dart';
import 'package:project/gpxMap.dart';
import 'package:project/objects/trail.dart';
import 'package:project/widgets/characteristics.dart';

<<<<<<< HEAD

//TrailCard can be used for previews
=======
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
class TrailCard extends StatelessWidget{
  final Trail trail;
  List<Trail> trailList = [];

  // Costruttore che accetta un parametro trail
  TrailCard({required this.trail}){
    trailList.add(trail);
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          //Map
=======
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
          Expanded(flex: 10, child:LayoutBuilder(
              builder: (context, constraints) {
                return GpxMap(trails: trailList, mapSize: constraints.biggest);
              },
            ),),
<<<<<<< HEAD
          //Name of the trail and buttons for "done", "favorite", "saved for later"
=======
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
          Expanded(flex: 3, child: Row(children: [
            Expanded(flex:3, child: Text('${trail.name}')),
            Expanded(flex:1, child: Icon(Icons.done)),
            Expanded(flex:1, child: Icon(Icons.favorite)),
            Expanded(flex:1, child: Icon(Icons.bookmark)),
          ],),),
<<<<<<< HEAD
          //characteristic of the trail
          Expanded(flex:1, child: Row(children: [
            SizedBox(width: 8),
            Expanded(flex:1, child: Text(trail.getTrailLevelText())),
            Expanded(flex:1, child: Text('${trail.lengthKm} km')),
            Expanded(flex:1, child: Text(trail.getWalkingTimeText())),
          ],)),
=======
          Expanded(flex:1, child: Row(children: [
            SizedBox(width: 8),
            Expanded(flex:1, child: Text(getTrailLevelText(trail.level))),
            Expanded(flex:1, child: Text('${trail.lengthKm} km')),
            Expanded(flex:1, child: Text(getWalkingTimeText(trail.walkingTime))),
          ],)),
          Expanded(flex: 2, child: Characteristics(percentage: trail.percentage))
          
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
  String getTrailLevelText(int level) {
    switch (level) {
      case 1:
        return 'Facile';
      case 2:
        return 'Intermedio';
      case 3:
        return 'Difficile';
      default:
        return 'Livello sconosciuto'; // Opzione di default nel caso in cui il livello non sia 1, 2 o 3
    }
  }

  String getWalkingTimeText(double minutes) {
    if(minutes < 60){
      return '${minutes} min';
    }
    else{
      final hours = minutes~/60;
      final remmin = minutes%60;
      return '${hours}hr ${remmin.round()}min';
    }
  }

>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
}