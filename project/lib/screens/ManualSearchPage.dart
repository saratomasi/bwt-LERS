import 'package:flutter/material.dart';
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
  final ScrollController _scrollController = ScrollController();

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
              height:110,
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
              child: sessionList(trailState),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sessionList(TrailState trailState) {
    var undoneTrails = trailState.notDoneTrails;
    return ListView.builder(
      controller: _scrollController,
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
            },
          ),
        );
      },
    );
  }
}