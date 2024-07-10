import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/widgets/customsearchbar.dart';
import 'package:project/widgets/trailCard.dart';


class ExploreLater extends StatefulWidget {
  const ExploreLater({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}


class _ExploreState extends State<ExploreLater> {

  @override
  Widget build(BuildContext context) {

    var trailState = context.watch<TrailState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('I want to explore...'),
      ),
      body: Consumer<TrailState>(
      builder: (context, trailState, child) {
        return trailState.savedTrails.isEmpty
          ? Center(
              child: Text('No trails at the moment'),
            )
          : Column(
              children:[
                // Barra di ricerca dei percorsi
                CustomSearchBar(
                  onSearch: (query) {
                    context.read<TrailState>().searchSavedTrails(query);
                  },
                ),
                // Elenco delle sessioni 
                Consumer<TrailState>(
                  builder: (context, trailState, child) {
                    return Expanded(child: exploreList(trailState),);}) 
              ],
            );
        },
      ),
    );
  }

  Widget exploreList(TrailState trailState) {
    var savedTrails = trailState.savedTrails;
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: savedTrails.length,
      itemBuilder: (context, index) {
        print('1 , ${savedTrails[index].name}, ${index}');
        Trail tmp = savedTrails[index];
        print('2 ${tmp.name}');
        return Consumer<TrailState>(
          builder: (context, trailState, child){
            return TrailCard(
              key: ValueKey(savedTrails[index].id),
              trail: savedTrails[index],
              onToggle: () async {
                setState(() {});
              },
            );});
      }
    );
  }

}