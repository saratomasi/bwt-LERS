import 'package:latlong2/latlong.dart';

//This class defines the object Mission

class Mission{
  String name;
  int id;
  LatLng coordinates;
  String imagePath = '';
  String description = '';
  int type; //0-nature, 1-history, 2-art, 3-food, 4-local
  bool isDone;

  Mission({required this.name,required this.id, required this.coordinates, required this.type, required this.description, this.isDone = false}){
    switch (type) {
      case 0:
        imagePath = 'lib/assets/naturalist.png';
        break;
      case 1:
        imagePath = 'lib/assets/historian.png';
        break;
      case 2:
        imagePath = 'lib/assets/artist.png';
        break;
      case 3:
        imagePath = 'lib/assets/food.png';
        break;
      case 4:
        imagePath = 'lib/assets/local.png';
        break;
      default:
        imagePath = 'lib/assets/logo.png';
    }
  }

  // Metodo di serializzazione JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'coordinates': [coordinates.latitude, coordinates.longitude],
        'imagePath': imagePath,
        'type': type,
        'description': description,
      };

  // Metodo di deserializzazione JSON
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      name: json['name'],
      id: json['id'],
      coordinates: LatLng(json['coordinates'][0], json['coordinates'][1]),
      type: json['type'], 
      description: json['description'],
    );
  }
}