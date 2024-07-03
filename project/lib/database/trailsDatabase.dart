import 'package:project/objects/trail.dart';
import 'package:project/database/pois.dart';
import 'dart:ui';

int id1 = 1;
Trail trail1 = Trail(
  name: 'Cammino di Sant\'Antonio', 
  gpxPath: 'lib/assets/CamminoSantAntonio.gpx',
  id: id1,
  level: 2, 
  lengthKm: 24, 
  walkingTime: 7*60,
  routeColor: 0xFF004000,
  pois: [poisDatabase[1]], 
);

int id2 = 2;
List<int> idPois = [2,3];
Trail trail2 = Trail(
  name: 'Anello da Santa Rita', 
  gpxPath: 'lib/assets/PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita.gpx',
  id: id2,
  level: 1, 
  lengthKm: 5.91, 
  walkingTime: 91,
  routeColor: 0xFFff3380,
  pois: [poisDatabase[2], poisDatabase[3]], 
);

Map<int,Trail> trailsDatabase = {
  id1 : trail1,
  id2 : trail2,
};

