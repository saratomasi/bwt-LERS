import 'package:flutter/material.dart';
import 'package:project/widgets/trailCard.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/trailPage.dart';

class ManualSearch extends StatefulWidget {
  const ManualSearch({super.key});

  @override
  State<ManualSearch> createState() => _ManualSearchState();
}

class _ManualSearchState extends State<ManualSearch> {

  @override
  Widget build(BuildContext context) {
    var trailState = context.watch<TrailState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Search'),
        backgroundColor: Colors.green.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width:500,
              height:150,
              child: Card(
                color: Colors.amber.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Here, you can choose any trail you prefer, regardless of your skill level. However, make sure to carefully check the difficulty level of each trail!',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: manualsearchList(trailState),
            ),
          ],
        ),
      ),
    );
  }

  Widget manualsearchList(TrailState trailState) {
var undoneTrails = trailState.notDoneTrails;
if (undoneTrails.isEmpty) {
      return Center(
        child: Text(
          'No trails available.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: undoneTrails.length,
      itemBuilder: (context, index) {
        print('1 , ${undoneTrails[index].name}, ${index}');
        Trail tmp = undoneTrails[index];
        print('2 ${tmp.name}');
        return Consumer<TrailState>(
          builder: (context, trailState, child){
            return TrailCard(
              key: ValueKey(undoneTrails[index].id),
              trail: undoneTrails[index],
              onToggle: () async {
                setState(() {});
              },
            );});
      }
    );
  }
  }