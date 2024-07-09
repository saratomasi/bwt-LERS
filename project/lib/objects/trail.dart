import 'package:project/objects/pointOfInterest.dart';

// This class defines the object Trail

class Trail{
  // instance variables
  String? name;                                 //name 
  int id;                                       //id in trails Database
  String gpxPath;                               //gpx file path
  int level;                                    //difficulty level
  num lengthKm;                                 //length in km
  double walkingTime;                           //time in min
  bool isDone;                                  //if done
  bool isFavorite;                              //if favorite
  bool isSaved;                                 //if saved for later
  DateTime date;                                //if done, correct date, if not, Alan Turing birthday.
  int routeColor;                               //color of the route
  List<PointOfInterest?> pois;                  //points of interest along the route
  List<int> percentage = [20, 20, 20, 20, 20];  //characteristics of the route => default: equally distributed

  // Constructor
  Trail({
    required this.name,
    required this.id,
    required this.gpxPath,
    required this.level,
    required this.lengthKm,
    required this.walkingTime,
    required this.routeColor,
    required this.pois,
    this.isDone = false,
    this.isFavorite = false,
    this.isSaved = false,
    DateTime? date,
  })  : this.date = date ?? DateTime.utc(1912, 06, 23) {
    _percChar(); //Calculates percentage based on pois
  }
  
  // METHODS:  

  // Metodo di serializzazione JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'gpxPath': gpxPath,
    'level': level,
    'lengthKm': lengthKm,
    'walkingTime': walkingTime,
    'isDone': isDone,
    'isFavorite': isFavorite,
    'isSaved': isSaved,
    'date': date.toIso8601String(),
    'routeColor': routeColor,
    'pois': pois.map((poi) => poi?.toJson()).toList(),
    'percentage': percentage,
  };

  // Metodo di deserializzazione JSON
  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
      name: json['name'],
      id: json['id'],
      gpxPath: json['gpxPath'],
      level: json['level'],
      lengthKm: json['lengthKm'],
      walkingTime: json['walkingTime'],
      routeColor: json['routeColor'],
      pois: (json['pois'] as List).map((item) => item == null ? null : PointOfInterest.fromJson(item)).toList(),
      isDone: json['isDone'],
      isFavorite: json['isFavorite'],
      isSaved: json['isSaved'],
      date: DateTime.parse(json['date']),
    );
  }

  //Calculates the char percentage of the trail based on pois
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

  // walking time as String
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

  // level as String
  String getTrailLevelText() {
    switch (level) {
      case 1:
        return 'Easy';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Difficult';
      case 4:
        return 'For Expert only';
      default:
        return 'Unknown';
    }
  }

  


}



