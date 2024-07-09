import 'package:latlong2/latlong.dart';

//This class defines the object PointOfInterest

class PointOfInterest{
  String name;
  int id;
  LatLng coordinates;
  String imagePath;
  int? nature;
  int? history;
  int? art;
  int? food;
  int? local;
  List<int> percentage;

  PointOfInterest({required this.name,required this.id, required this.coordinates, required this.percentage, this.imagePath = 'lib/assets/logo.png', this.nature, this.history, this.art, this.food, this.local}){
    nature = percentage[0];
    history = percentage[1];
    art = percentage[2];
    food = percentage[3];
    local = percentage[4];
  }

  // Metodo di serializzazione JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'coordinates': [coordinates.latitude, coordinates.longitude],
        'imagePath': imagePath,
        'nature': nature,
        'history': history,
        'art': art,
        'food': food,
        'local': local,
        'percentage': percentage,
      };

  // Metodo di deserializzazione JSON
  factory PointOfInterest.fromJson(Map<String, dynamic> json) {
    return PointOfInterest(
      name: json['name'],
      id: json['id'],
      coordinates: LatLng(json['coordinates'][0], json['coordinates'][1]),
      imagePath: json['imagePath'],
      nature: json['nature'],
      history: json['history'],
      art: json['art'],
      food: json['food'],
      local: json['local'],
      percentage: List<int>.from(json['percentage']),
    );
  }
}