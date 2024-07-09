import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/widgets/characteristics.dart';
import 'package:project/widgets/gpxMap.dart';

class TrailPage extends StatefulWidget {
  final Trail trail;
  TrailPage({required this.trail});

  @override
  _TrailPageState createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {

  late Trail trail;
  late List<Trail> trailList;

  @override
  void initState() {
    super.initState();
    trail = widget.trail;
    trailList = [trail];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        trail.date = picked;
        trail.isDone = true;
      });
      context.read<TrailState>().updateTrail(trail);
    }
  }


  @override
  Widget build(BuildContext context) {
    var trailState = context.watch<TrailState>();

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
            Expanded(
              flex:1, 
              child: IconButton(
                icon:Icon(trail.isDone ? Icons.task_alt_rounded : Icons.add_task_rounded),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (trail.isDone) {
                    setState(() {
                      trail.isDone = false;
                      trail.date = DateTime.utc(1912, 06, 23);
                    });
                    trailState.updateTrail(trail);
                  } else {
                    await _selectDate(context);
                  }
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
                icon: Icon(trail.isSaved ? Icons.alarm_on_rounded : Icons.more_time_rounded),
                //alternativa icone: event_available e calendar_month
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
          //Characteristics percentages
          Expanded(flex: 2, child: Characteristics(percentage: trail.percentage))
          
        ],
      ),
    );
  }

}