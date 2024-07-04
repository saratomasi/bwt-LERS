import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:gpx/gpx.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project/objects/pointOfInterest.dart';
import 'package:project/utils/gpxMethods.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_toolkit;

// This class defines the object Trail

class Trail{
  // instance variables
  String? name;                                 //name 
  String gpxPath;                               //gpx file path
  int id;                                       //id in trails Database
  int level = 0;                                //difficulty level
  num lengthKm = 0;                             //length in km
  double walkingTime = 0;                       //time in min
  bool completed = false;                       //if done
  int routeColor;                               //color of the route
  List<PointOfInterest?> pois;                  //points of interest along the route
  List<int> percentage = [20, 20, 20, 20, 20];  //characteristics of the route

  // constructor
  Trail({required this.name, required this.gpxPath, required this.id, required this.pois, required this.level, required this.lengthKm, required this.walkingTime, required this.routeColor,}){
    _percChar();
  }
  
  // METHODS:

  //it set the trail as completed
  void done(){
    completed = true;
    //aggiungere tipo un count per segnare quante volte uno lo fa?
    //aggiungere data per sapere quando uno lo fa?
  }

  //Calculates the char percentage of the trail
  void _percChar() {
    int totalNature  = 0;
    int totalHistory = 0;
    int totalArt     = 0;
    int totalFood    = 0;
    int totalLocal   = 0;
    int poiCount     = 0;
    
    for (var poi in pois) {
      if (poi != null) {
        totalNature  += poi.nature ?? 0;
        totalHistory += poi.history ?? 0;
        totalArt     += poi.art ?? 0;
        totalFood    += poi.food ?? 0;
        totalLocal   +=  poi.local ?? 0;
        poiCount++;
      }
    }

    if (poiCount>0){
      percentage[0] = (totalNature/poiCount).round();
      percentage[1] = (totalHistory/poiCount).round();
      percentage[2] = (totalArt/poiCount).round();
      percentage[3] = (totalFood/poiCount).round();
      percentage[4] = (totalLocal/poiCount).round();
    }

    int sum = percentage.reduce((a, b) => a + b);
    if(sum>100){ percentage[4] -= sum-100; }
  }

  String getWalkingTimeText() {
    if(walkingTime < 60){
      return '${walkingTime} min';
    }
    else{
      final hours = walkingTime~/60;
      final remmin = walkingTime%60;
      return '${hours}hr ${remmin.round()}min';
    }
  }

  String getTrailLevelText() {
    switch (level) {
      case 1:
        return 'Easy';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Difficult';
      case 4:
        return 'Extremely Difficult';
      default:
        return 'Livello sconosciuto';
    }
  }

  


}



