import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/trailPage.dart';
import 'package:project/widgets/gpxMap.dart';



//TrailCard can be used for previews
class TrailCard extends StatefulWidget {
  final Trail trail;
  TrailCard({required this.trail});

  @override
  _TrailCardState createState() => _TrailCardState();
}

class _TrailCardState extends State<TrailCard> {

  late Trail trail;
  late List<Trail> trailList;

  @override
  void initState() {
    super.initState();
    trail = widget.trail;
    trailList = [trail];
  }

  @override
  Widget build(BuildContext context) {
    var trailState = context.watch<TrailState>();

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
          //Trail name and buttons for "done", "favorite", "saved for later"
          Expanded(flex: 3, child: Row(children: [
            Expanded(flex:3, child: TextButton(
              child: Text('${trail.name}'), 
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrailPage(trail: trail)));
                },
              ),),
            Expanded(
              flex:1, 
              child: IconButton(
                icon:Icon(trail.isDone ? Icons.done_rounded : Icons.done_outline_rounded),
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  setState(() {
                    trail.isDone = !trail.isDone;
                  });
                  trailState.updateTrail(trail);
                },)),
            Expanded(
              flex:1, 
              child: IconButton(
                icon:Icon(trail.isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    trail.isFavorite = !trail.isFavorite;
                  });
                  trailState.updateTrail(trail);
                },)),
            Expanded(
              flex:1, 
              child: IconButton(
                icon: Icon(trail.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    trail.isSaved = !trail.isSaved;
                  });
                  trailState.updateTrail(trail);
                },)),
          ],),),
          //Level, length and time
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