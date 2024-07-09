import 'package:latlong2/latlong.dart';

//This class defines the object PointOfInterest

class PointOfInterest{
  String name;
  LatLng coordinates;
  String imagePath;
  int? nature;
  int? history;
  int? art;
  int? food;
  int? local;
  List<int> percentage;

  PointOfInterest({required this.name, required this.coordinates, required this.percentage, this.imagePath = 'lib/assets/logo.png'}){
    nature = percentage[0];
    history = percentage[1];
    art = percentage[2];
    food = percentage[3];
    local = percentage[4];
  }
}