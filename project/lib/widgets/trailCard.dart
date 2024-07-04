import 'package:flutter/material.dart';
import 'package:project/gpxMap.dart';
import 'package:project/objects/trail.dart';
import 'package:project/widgets/characteristics.dart';


//TrailCard can be used for previews
class TrailCard extends StatelessWidget{
  final Trail trail;
  List<Trail> trailList = [];

  // Costruttore che accetta un parametro trail
  TrailCard({required this.trail}){
    trailList.add(trail);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          //Map
          Expanded(flex: 10, child:LayoutBuilder(
              builder: (context, constraints) {
                return GpxMap(trails: trailList, mapSize: constraints.biggest);
              },
            ),),
          //Name of the trail and buttons for "done", "favorite", "saved for later"
          Expanded(flex: 3, child: Row(children: [
            Expanded(flex:3, child: Text('${trail.name}')),
            Expanded(flex:1, child: Icon(Icons.done)),
            Expanded(flex:1, child: Icon(Icons.favorite)),
            Expanded(flex:1, child: Icon(Icons.bookmark)),
          ],),),
          //characteristic of the trail
          Expanded(flex:1, child: Row(children: [
            SizedBox(width: 8),
            Expanded(flex:1, child: Text(trail.getTrailLevelText())),
            Expanded(flex:1, child: Text('${trail.lengthKm} km')),
            Expanded(flex:1, child: Text(trail.getWalkingTimeText())),
          ],)),
        ],
      ),
    );
  }

}