import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:gpx/gpx.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project/objects/pointOfInterest.dart';
import 'package:project/utils/gpxMethods.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_toolkit;

class Trail{
  // instance variables
  String? name;
  String gpxPath = '';
  //Gpx gpxFile ;
  List<PointOfInterest?> pois;
  int level = 0;
  num lengthKm = 0;
  double walkingTime = 0;
  bool completed = false;


  List<maps_toolkit.LatLng> convertToMapsToolkitLatLng(List<latlong2.LatLng> points) {
    return points.map((point) => maps_toolkit.LatLng(point.latitude, point.longitude)).toList();
  }


  // constructors
  Trail({required this.name, required this.pois, required this.level, required this.lengthKm, required this.walkingTime}){
    gpxPath = 'lib/assets/$name.gpx';
    //gpxFile = loadGpxFile(gpxPath) as Gpx;
    //List<latlong2.LatLng> coordinates = getCoordinatesFromGpx(gpxFile);
    //lengthKm = maps_toolkit.SphericalUtil.computeLength(convertToMapsToolkitLatLng(coordinates));
  }
  
  // methods
  //it set the trail as completed
  void done(){
    completed = true;
    //aggiungere tipo un count per segnare quante volte uno lo fa?
    //aggiungere data per sapere quando uno lo fa?
  }

  //you get the gpx file of the trail.
  Future<Gpx> getGpxFile() async {
    final gpx = await loadGpxFile(gpxPath);
    return gpx;
  }




  


}



