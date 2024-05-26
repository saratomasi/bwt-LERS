import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:gpx/gpx.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

Future<Gpx> loadGpxFile(String filePath) async {
  final gpxString = await rootBundle.loadString(filePath);
  final xmlGpx = GpxReader().fromString(gpxString);
  return xmlGpx;
}

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

class GpxMapScreen extends StatefulWidget {
  @override
  _GpxMapScreenState createState() => _GpxMapScreenState();
}

class _GpxMapScreenState extends State<GpxMapScreen> {
  List<LatLng> gpxPoints = [];

  @override
  void initState() {
    super.initState();
    loadGpx();
  }

  Future<void> loadGpx() async {
    final gpx = await loadGpxFile('lib/assets/PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita.gpx');
    final points = getCoordinatesFromGpx(gpx);
    setState(() {
      gpxPoints = points;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPX Viewer'),
      ),
      body: FlutterMap(
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
        PolylineLayer(
          polylines: [
            Polyline(
              points: gpxPoints,
              strokeWidth: 4,
              color: Colors.blue,
            ),
          ],
          ),
        ],
      ),
    );
  }
}
