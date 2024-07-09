import 'package:latlong2/latlong.dart';
import 'package:project/objects/pointOfInterest.dart';

int id1 = 1;
PointOfInterest poi1 = PointOfInterest(
  name: 'Santuario del Noce (Santuari Antoniani)', 
  coordinates: LatLng(45.57609822752844, 11.932222112895737), 
  imagePath: 'lib/assets/Santuario_del_noce_(Camposampiero)_03.jpg',
  percentage: [0,50,25,0,25]
);

int id2 = 2;
PointOfInterest poi2 = PointOfInterest(
  name: 'Prato della Valle', 
  coordinates: LatLng(45.39856774078998, 11.876582141723976), 
  imagePath: 'lib/assets/prato_della_valle.jpg',
  percentage: [5,35,50,0,10]
);

int id3 = 3;
PointOfInterest poi3 = PointOfInterest(
  name: 'Piazza delle Erbe', 
  coordinates: LatLng(45.40683755395249, 11.87563621288851), 
  percentage: [0,25,25,25,25]
);



Map<int,PointOfInterest> poisDatabase = {
  id1 : poi1, 
  id2 : poi2,
  id3 : poi3,
};