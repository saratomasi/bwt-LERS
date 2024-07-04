import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project/objects/pointOfInterest.dart';
import 'package:project/widgets/characteristics.dart';

class PoiPage extends StatelessWidget{
  final PointOfInterest point;
  List<Marker> markers = [];
    

  // Constructor with parameter trail
  PoiPage({required this.point}){
    markers.add(Marker(point: point.coordinates, width: 80, height: 80, child: Icon(Icons.location_on)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          //Image and Map
          Expanded(flex: 10, child:
            FlutterMap(
              options: MapOptions(
                initialCenter: point.coordinates,
                initialZoom: 15,
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
                MarkerLayer(markers: markers),
              ]
            )),
          //Trail name
          Expanded(flex: 3, child: Text('${point.name}')),
          Expanded(flex: 10, child: Image.asset('lib/assets/logo.png')),
          //Characteristics percentages
          Expanded(flex: 3, child: Characteristics(percentage: point.percentage),),
        ],
      ),
    );
  }

}