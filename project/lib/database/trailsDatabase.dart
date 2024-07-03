import 'package:project/objects/trail.dart';
import 'package:project/database/pois.dart';
import 'dart:ui';

<<<<<<< HEAD
Trail trail1 = Trail(
  name: 'Cammino di Sant\'Antonio', 
  gpxPath: 'lib/assets/CamminoSantAntonio.gpx',
  id: 1,
=======
int id1 = 1;
Trail trail1 = Trail(
  name: 'Cammino di Sant\'Antonio', 
  gpxPath: 'lib/assets/CamminoSantAntonio.gpx',
  id: id1,
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
  level: 2, 
  lengthKm: 24, 
  walkingTime: 7*60,
  routeColor: 0xFF004000,
  pois: [poisDatabase[1]], 
);

<<<<<<< HEAD
Trail trail2 = Trail(
  name: 'Anello da Santa Rita', 
  gpxPath: 'lib/assets/PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita.gpx',
  id: 2,
=======
int id2 = 2;
List<int> idPois = [2,3];
Trail trail2 = Trail(
  name: 'Anello da Santa Rita', 
  gpxPath: 'lib/assets/PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita.gpx',
  id: id2,
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
  level: 1, 
  lengthKm: 5.91, 
  walkingTime: 91,
  routeColor: 0xFFff3380,
  pois: [poisDatabase[2], poisDatabase[3]], 
);

<<<<<<< HEAD
Trail trail3 = Trail(
  name: 'Da Brasseo all\'Abbazia di Praglia', 
  gpxPath: 'lib/assets/Bresseo_AbbaziaPraglia_giro_anello.gpx', 
  id: 3, 
  pois: [poisDatabase[2], poisDatabase[3]], 
  level: 2, 
  lengthKm: 9.14, 
  walkingTime: 171, 
  routeColor: 0xFF4931AF
);

Trail trail4 = Trail(
  name: 'Sentiero Atestino', 
  gpxPath: 'lib/assets/SentieroAtestino_giro_anello_ParcoRegionaleColliEuganei.gpx', 
  id: 4, 
  pois: [poisDatabase[2], poisDatabase[3]], 
  level: 3, 
  lengthKm: 18.9, 
  walkingTime: 377, 
  routeColor: 0xFF66AB0D
);

Trail trail5 = Trail(
  name: 'Piazzola S.B.: Villa e villaggio operaio Camerini', 
  gpxPath: 'lib/assets/VillaContarini_VillaggioOperaio.gpx', 
  id: 5, 
  pois: [poisDatabase[2], poisDatabase[3]], 
  level: 1, 
  lengthKm: 8.45, 
  walkingTime: 120, 
  routeColor: 0xFFB75427
);

Trail trail6 = Trail(
  name: 'Villa Camerini e Ostiglia ciclabile', 
  gpxPath: 'lib/assets/VillaContarini_Ostiglia.gpx', 
  id: 6, 
  pois: [poisDatabase[2], poisDatabase[3]], 
  level: 2, 
  lengthKm: 9.49, 
  walkingTime: 150, 
  routeColor: 0xFF356E26
);

Trail trail7 = Trail(
  name: 'Cittadella e le sue mura', 
  gpxPath: 'lib/assets/Salita_mura_Cittadella.gpx', 
  id: 7, 
  pois: [poisDatabase[2], poisDatabase[3]], 
  level: 1, 
  lengthKm: 5.23, 
  walkingTime: 79, 
  routeColor: 0xFF918993
);


Map<int,Trail> trailsDatabase = {
  trail1.id : trail1,
  trail2.id : trail2,
  trail3.id : trail3,
  trail4.id : trail4,
  trail5.id : trail5,
  trail6.id : trail6,
  trail7.id : trail7,
=======
Map<int,Trail> trailsDatabase = {
  id1 : trail1,
  id2 : trail2,
>>>>>>> 195db1e (fix of GpxMap, trailCard, Sessions, added Characteristics widget)
};

