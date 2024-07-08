import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/objects/trail.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/widgets/customsearchbar.dart';
import 'package:project/widgets/trailCard.dart';


class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}


class _ExploreState extends State<Favorites> {

  @override
  Widget build(BuildContext context) {

    var trailState = context.watch<TrailState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My favourite adventures...'),
      ),
      body: Consumer<TrailState>(
      builder: (context, trailState, child) {
        return trailState.favoriteTrails.isEmpty
          ? Center(
              child: Text('No trails at the moment'),
            )
          : Column(
              children:[
                // Barra di ricerca dei percorsi
                CustomSearchBar(
                  onSearch: (query) {
                    context.read<TrailState>().searchFavoriteTrails(query);
                  },
                ),
                // Elenco delle sessioni 
                Consumer<TrailState>(
                  builder: (context, trailState, child) {
                    return Expanded(child: favoriteList(trailState),);}) 
              ],
            );
        },
      ),
    );
  }

  Widget favoriteList(TrailState trailState) {
    var favoriteTrails = trailState.favoriteTrails;
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: favoriteTrails.length,
      itemBuilder: (context, index) {
        print('1 , ${favoriteTrails[index].name}, ${index}');
        Trail tmp = favoriteTrails[index];
        print('2 ${tmp.name}');
        return Consumer<TrailState>(
          builder: (context, trailState, child){
            return TrailCard(
              key: ValueKey(favoriteTrails[index].id),
              trail: favoriteTrails[index],
              onToggle: () async {
                setState(() {});
              },
            );});
      }
    );
  }

}