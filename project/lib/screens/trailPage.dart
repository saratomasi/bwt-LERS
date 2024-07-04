import 'package:flutter/material.dart';
import 'package:project/gpxMap.dart';
import 'package:project/objects/trail.dart';
import 'package:project/widgets/characteristics.dart';

class TrailPage extends StatelessWidget{
  final Trail trail;
  List<Trail> trailList = [];

  // Constructor with parameter trail
  TrailPage({required this.trail}){
    trailList.add(trail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          //Map
          Expanded(flex: 10, child:LayoutBuilder(
              builder: (context, constraints) {
                return GpxMap(trails: trailList, mapSize: constraints.biggest);
              },
            ),),
          //Trail name and buttons for "done", "favorite", "saved for later"
          Expanded(flex: 3, child: Row(children: [
            Expanded(flex:3, child: Text('${trail.name}')),
            Expanded(flex:1, child: Icon(Icons.done)),
            Expanded(flex:1, child: Icon(Icons.favorite)),
            Expanded(flex:1, child: Icon(Icons.bookmark)),
          ],),),
          //Level, length and time
          Expanded(flex:1, child: Row(children: [
            SizedBox(width: 8),
            Expanded(flex:1, child: Text(trail.getTrailLevelText())),
            Expanded(flex:1, child: Text('${trail.lengthKm} km')),
            Expanded(flex:1, child: Text(trail.getWalkingTimeText())),
          ],)),
          //Characteristics percentages
          Expanded(flex: 2, child: Characteristics(percentage: trail.percentage))
          
        ],
      ),
    );
  }

}