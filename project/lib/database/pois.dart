import 'package:latlong2/latlong.dart';
import 'package:project/objects/pointOfInterest.dart';

//File used to store all the available points of interest.

PointOfInterest poi1 = PointOfInterest(
  name: 'Santuario del Noce (Santuari Antoniani)', 
  id: 1,
  coordinates: LatLng(45.57609822752844, 11.932222112895737), 
  imagePath: 'lib/assets/Santuario_del_noce_(Camposampiero)_03.jpg',
  percentage: [0,50,35,0,15]
);

PointOfInterest poi2 = PointOfInterest(
  name: 'Prato della Valle', 
  id: 2,
  coordinates: LatLng(45.39856774078998, 11.876582141723976), 
  imagePath: 'lib/assets/prato_della_valle.jpg',
  percentage: [5,35,50,0,10]
);

PointOfInterest poi3 = PointOfInterest(
  name: 'Piazza delle Erbe', 
  id: 3,
  coordinates: LatLng(45.40683755395249, 11.87563621288851), 
  percentage: [0,25,25,25,25]
);

PointOfInterest poi4 = PointOfInterest(
  name: 'Santuario della Visione', 
  id: 4,
  coordinates: LatLng(45.57411561318794, 11.931632026925817), 
  imagePath: 'lib/assets/Santuario-della-Visione.jpg',
  percentage: [0,50,35,0,15]
);



Map<int,PointOfInterest> poisDatabase = {
  poi1.id : poi1, 
  poi2.id : poi2,
  poi3.id : poi3,
  poi4.id : poi4,
};