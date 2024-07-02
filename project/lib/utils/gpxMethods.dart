import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:gpx/gpx.dart';
import 'package:flutter/services.dart' show rootBundle;

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