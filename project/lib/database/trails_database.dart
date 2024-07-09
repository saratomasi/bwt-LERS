import 'package:project/database/pois.dart';
import 'package:project/objects/trail.dart';

//File used to store all the available trails.

Trail trail1 = Trail(
  name: 'Cammino di Sant\'Antonio', 
  id: 1,
  gpxPath: 'lib/assets/gpx_files/CamminoSantAntonio.gpx',
  level: 2, 
  lengthKm: 24, 
  walkingTime: 420,
  routeColor: 0xFF004000,
  pois: [poisDatabase[1], poisDatabase[4], poisDatabase[5]],
);

Trail trail2 = Trail(
  name: '', 
  id: 2,
  gpxPath: 'lib/assets/gpx_files/PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita.gpx',
  level: 1, 
  lengthKm: 5.91, 
  walkingTime: 91,
  routeColor: 0xFFff3380,
  pois: [poisDatabase[2], poisDatabase[3], poisDatabase[6]],
);

Trail trail3 = Trail(
  name: 'Da Brasseo all\'Abbazia di Praglia', 
  id: 3, 
  gpxPath: 'lib/assets/gpx_files/Bresseo_AbbaziaPraglia_giro_anello.gpx', 
  level: 2, 
  lengthKm: 9.14, 
  walkingTime: 171, 
  routeColor: 0xFF4931AF,
  pois: [],
);

Trail trail4 = Trail(
  name: 'Sentiero Atestino', 
  id: 4,
  gpxPath: 'lib/assets/gpx_files/SentieroAtestino_giro_anello_ParcoRegionaleColliEuganei.gpx',  
  level: 3, 
  lengthKm: 18.9, 
  walkingTime: 377, 
  routeColor: 0xFF66AB0D,
  pois: [],
);

Trail trail5 = Trail(
  name: 'Piazzola S.B.: Villa e villaggio operaio Camerini', 
  id: 5, 
  gpxPath: 'lib/assets/gpx/files/VillaContarini_VillaggioOperaio.gpx', 
  level: 1, 
  lengthKm: 8.45, 
  walkingTime: 120, 
  routeColor: 0xFFB75427,
  pois: [],
);

Trail trail6 = Trail(
  name: 'Villa Camerini e Ostiglia ciclabile', 
  id: 6,
  gpxPath: 'lib/assets/gpx_files/VillaContarini_Ostiglia.gpx',
  level: 2, 
  lengthKm: 9.49, 
  walkingTime: 150, 
  routeColor: 0xFF356E26,
  pois: [poisDatabase[2], poisDatabase[3]],
);

Trail trail7 = Trail(
  name: 'Cittadella e le sue mura', 
  id: 7, 
  gpxPath: 'lib/assets/gpx/files/Salita_mura_Cittadella.gpx',
  level: 1, 
  lengthKm: 5.23, 
  walkingTime: 79, 
  routeColor: 0xFF918993,
  pois: [],
);


Map<int,Trail> trailsDatabase = {
  trail1.id : trail1,
  trail2.id : trail2,
  trail3.id : trail3,
  trail4.id : trail4,
  trail5.id : trail5,
  trail6.id : trail6,
  trail7.id : trail7,
};