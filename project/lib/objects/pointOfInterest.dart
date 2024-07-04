import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

//This class defines the object PointOfInterest

class PointOfInterest{
  String name;
  LatLng coordinates;
  int? nature;
  int? history;
  int? art;
  int? food;
  int? local;
  List<int> percentage;

  PointOfInterest({required this.name, required this.coordinates, required this.percentage}){
    nature = percentage[0];
    history = percentage[1];
    art = percentage[2];
    food = percentage[3];
    local = percentage[4];
  }
}