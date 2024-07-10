import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/screens/trailPage.dart';
import 'package:project/widgets/customsearchbar.dart';
import 'package:project/widgets/gpxMap.dart';


class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  _SessionsState createState() => _SessionsState();
}


class _SessionsState extends State<Sessions> {

  @override
  Widget build(BuildContext context) {

    var trailState = context.watch<TrailState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sessions'),
      ),
      body: trailState.doneTrails.isEmpty
          ? Center(
              child: Text('No activities at the moment'),
            )
          : Column(
            children:[
              // Barra di ricerca dei percorsi
              CustomSearchBar(
                onSearch: (query) {
                  context.read<TrailState>().searchDoneTrails(query);
                  },
              ),
              // Mappa di riepilogo
              Expanded(flex: 3, 
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Consumer<TrailState>(
                    builder: (context, trailState, _) {
                      return GpxMap(
                        trails: trailState.doneTrails,
                        mapSize: constraints.biggest,
                        );
                    },
                  );
                },
              ),),
              // Elenco delle sessioni 
              Expanded(flex: 3, child: sessionList(trailState),), 
            ],
          )
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Session',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value){
        //logica di ricerca qui
        },
      ),
    );
  }

  Widget sessionList(TrailState trailState) {
    var doneTrails = trailState.doneTrails;
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: doneTrails.length,
      itemBuilder: (context, index) {
        Trail tmp = doneTrails[index];
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
              // Aggiorna doneTrails se il trail è stato modificato
              if (updatedTrail != null) {
                setState(() {
                  trailState.updateTrail(updatedTrail);
                });
              }
            }
          ),
        );
      },
    );
  }
}