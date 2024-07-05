import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:project/gpxMap.dart';
import 'package:project/screens/trailPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gpx/gpx.dart';
import 'package:project/database/trailsDatabase.dart';
import 'package:project/objects/trail.dart';

List<Trail> myTrails = trailsDatabase.values.toList();


class Sessions extends StatelessWidget {
  const Sessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sessions'),
      ),
      body: Column(
        children:[
          searchBar(), // Barra di ricerca dei percorsi
          Expanded(flex: 3, 
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GpxMap(trails: myTrails, mapSize: constraints.biggest);
              },
            ),), // Mappa di riepilogo
          Expanded(flex: 3, child: sessionList(),), // Elenco delle sessioni
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

  Widget mapView() {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(45.407733, 11.873339),
            initialZoom: 9.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget sessionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: trailsDatabase.length,
      itemBuilder: (context, index) {
        Trail tmp = trailsDatabase[index+1]!;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('${tmp.name}'),
            subtitle: Text('Data'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
               Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TrailPage(trail: tmp)));
            },
          ),
        );
      },
    );
  }
}