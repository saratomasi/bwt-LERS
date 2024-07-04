import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:gpx/gpx.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project/screens/poiPage.dart';
import 'package:project/screens/poiPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project/objects/trail.dart';
import 'package:project/objects/pointOfInterest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

//Load gpx file from path
Future<Gpx> loadGpxFile(String filePath) async {
  final gpxString = await rootBundle.loadString(filePath);
  final xmlGpx = GpxReader().fromString(gpxString);
  return xmlGpx;
}

//List of all points of the route from gpx file
List<LatLng> getCoordinatesFromGpx(Gpx gpx) {
  final List<LatLng> coordinates = [];
  for (var track in gpx.trks) {
    for (var segment in track.trksegs) {
      for (var point in segment.trkpts) {
        coordinates.add(LatLng(point.lat!, point.lon!));
      }
    }
  }
  return coordinates;
}

//Get points from trail object
Future<List<LatLng>> loadGpxPoints(Trail trail) async {
    final gpx = await loadGpxFile(trail.gpxPath);
    final points = getCoordinatesFromGpx(gpx);
    return points;
}

LatLngBounds calculateBounds(List<LatLng> points) {
  double minLat = 90.0;
  double maxLat = -90.0;
  double minLon = 180.0;
  double maxLon = -180.0;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLon) minLon = point.longitude;
      if (point.longitude > maxLon) maxLon = point.longitude;
    }

  return LatLngBounds(LatLng(minLat, minLon), LatLng(maxLat, maxLon));
}

LatLng calculateCenter(LatLngBounds bounds) {
  return LatLng(
    (bounds.southWest.latitude + bounds.northEast.latitude) / 2,
    (bounds.southWest.longitude + bounds.northEast.longitude) / 2,
  );
}

double calculateZoom(LatLngBounds bounds, Size mapSize) {
  const worldDimension = 256;
  const double zoomMax = 15;
  const double marginFactor = 1.6;

  double latFraction = (bounds.northEast.latitude - bounds.southWest.latitude) / 360.0 * marginFactor;
  double lngDiff = bounds.northEast.longitude - bounds.southWest.longitude;
  double lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360.0 * marginFactor;

  double latZoom = log(mapSize.height / worldDimension / latFraction) / ln2;
  double lngZoom = log(mapSize.width / worldDimension / lngFraction) / ln2;

  return min(min(latZoom, lngZoom), zoomMax);
}

class GpxMap extends StatefulWidget {

  final List<Trail> trails;
  final Size mapSize;
  List<int> colors = [];

  GpxMap({required this.trails, required this.mapSize}){
    for(int i=0; i<trails.length; i++){
      Trail tmp = trails[i];
      colors.add(tmp.routeColor);
    }
  }

  @override
  _GpxMapState createState() => _GpxMapState();
}

class _GpxMapState extends State<GpxMap> {
  List<List<LatLng>> gpxPoints = [];
  LatLng? mapCenter;
  double mapZoom = 12;

  @override
  void initState() {
    super.initState();
    loadAllPoints();
  }

  Future<void> loadAllPoints() async{
    List<List<LatLng>> allPoints = [];
    List<LatLng> allCoordinates = [];
    for (Trail tr in widget.trails){
      final points = await loadGpxPoints(tr);
      allPoints.add(points);
      allCoordinates.addAll(points);
    }

    LatLngBounds bounds = calculateBounds(allCoordinates);
      setState(() {
        gpxPoints = allPoints;

        mapCenter = calculateCenter(bounds);
        mapZoom   = calculateZoom(bounds, widget.mapSize);
      });
  }


  @override
  Widget build(BuildContext context) {
    if (gpxPoints.isEmpty) {
      //Loading indicator
      return Center(child: CircularProgressIndicator());
    }
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FlutterMap(
            options: MapOptions(
              initialCenter: mapCenter ?? LatLng(45.407733, 11.873339),
              initialZoom: mapZoom,
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
              for (int i = 0; i<widget.trails.length; i++)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: gpxPoints[i],
                      strokeWidth: 4,
                      color: Color(widget.colors[i]),
                    ),
                  ],
                ),
              for (int i = 0; i<widget.trails.length; i++)
              if(widget.trails[i].pois.isNotEmpty)
                MarkerLayer(
                  markers: widget.trails[i].pois.map((point) {
                    return Marker(
                      width: 80.0,
                      height: 80.0,
                      point: point!.coordinates, 
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.black,
                        iconSize: 25.0,
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (ctx) => AlertDialog(
                              title: TextButton(
                                child: Text(point.name), 
                                onPressed: (){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => PoiPage(point: point)));
                                },),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },)
                              ],

                            ));
                        }
                      ),);
                  }).toList(),
                ),
            
            ],
          );
        }
      )
    );
  }
}
