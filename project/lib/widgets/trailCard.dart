import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/trailPage.dart';
import 'package:project/widgets/gpxMap.dart';



//TrailCard can be used for previews
class TrailCard extends StatefulWidget {
  final Trail trail;
  final VoidCallback onToggle;
  TrailCard({required this.trail, required this.onToggle, Key? key}) : super(key: key);

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

  void _showUndoSnackbar(BuildContext context, String message, VoidCallback undoAction) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: undoAction,
      ),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var trailState = context.watch<TrailState>();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          //Map
          //Padding(
            //padding: EdgeInsets.all(8.0),
            //child:LayoutBuilder(
              //builder: (context, constraints) {
                //return GpxMap(trails: trailList, mapSize: constraints.biggest);
              //},
            //),),
          //Trail name and buttons for "done", "favorite", "saved for later"
          TextButton(
            child: Text('${trail.name}',
            style: TextStyle(fontSize: 14.0)
            ), 
              onPressed: () async {
                var updatedTrail = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrailPage(trail: trail)),
                );
                // Aggiorna doneTrails se il trail è stato modificato
                if (updatedTrail != null) {
                  setState(() {
                    trailState.updateTrail(updatedTrail);
                  });
                  widget.onToggle();
                }
              }
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon:Icon(trail.isDone ? Icons.task_alt_rounded : Icons.add_task_rounded),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                        if (trail.isDone) {
                          final previousDate = trail.date;
                          setState(() {
                            trail.isDone = false;
                            trail.date = DateTime.utc(1912, 06, 23);
                          });
                          trailState.updateTrail(trail);
                          _showUndoSnackbar(context, 'Marked as not done', () {
                            setState(() {
                              trail.isDone = true;
                              trail.date = previousDate; // Riporta la data precedentemente salvata
                            });
                            trailState.updateTrail(trail);
                          });
                        } else {
                          await _selectDate(context);
                        }
                      },),
                      IconButton(
            icon:Icon(trail.isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
                    final previousValue = trail.isFavorite;
                    setState(() {
                      trail.isFavorite = !trail.isFavorite;
                    });
                    trailState.updateTrail(trail);
                    if (!trail.isFavorite) {
                      _showUndoSnackbar(context, 'Removed from favorites', () {
                        setState(() {
                          trail.isFavorite = previousValue;
                        });
                        trailState.updateTrail(trail);
                      });
                    }
                  },),
          IconButton(
            icon: Icon(trail.isSaved ? Icons.alarm_on_rounded : Icons.more_time_rounded),
            //alternativa icone: event_available e calendar_month
            color: Theme.of(context).primaryColor,
            onPressed: () {
                    final previousValue = trail.isSaved;
                    setState(() {
                      trail.isSaved = !trail.isSaved;
                    });
                    trailState.updateTrail(trail);
                    if (!trail.isSaved) {
                      _showUndoSnackbar(context, 'Removed from "explore later"', () {
                        setState(() {
                          trail.isSaved = previousValue;
                        });
                        trailState.updateTrail(trail);
                      });
                    }
                  },),
            ],
          ),
          SizedBox(height: 15,),
          //Level, length and time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(width: 12),
            Text(trail.getTrailLevelText()),
            SizedBox(width: 30),
            Text('${trail.lengthKm} km'),
            SizedBox(width: 30),
            Text(trail.getWalkingTimeText()),
          ],),          
        ],
      ),
    );
  }

}