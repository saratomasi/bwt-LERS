import 'package:latlong2/latlong.dart';
import 'package:project/objects/mission.dart';


Mission m1 = Mission(
  name: 'gelato', 
  id: 1, 
  coordinates: LatLng(45.40073725559155, 11.875941208750046),
  type: 3, 
  description: 'Taste a scoop of the best ice cream in Padua at Gelateria Portogallo'
);

Mission m2 = Mission(
  name: '3senza', 
  id: 2, 
  coordinates: LatLng(45.39856774078998, 11.876582141723976),
  type: 4, 
  description: 'Interview a local person and find out what the famous "3 Senza" of Padua are'
);

Mission m3 = Mission(
  name: 'dottooooree', 
  id: 2, 
  coordinates: LatLng(45.40677884320638, 11.877142853121425), 
  type: 4, 
  description: 'Sing the song "Dottore, dottore" for a newly graduated student: you can recognize them by their laurel wreath'
);

Mission m4 = Mission(
  name: 'pedrocchi', 
  id: 4, 
  coordinates: LatLng(45.40788788368759, 11.877206539096179), 
  type: 3, 
  description: 'Taste a mint coffee at Caffè Pedrocchi'
);

Mission m5 = Mission(
  name: 'apePadova', 
  id: 5, 
  coordinates: LatLng(45.407248382320184, 11.87561315521693), 
  type: 3, 
  description: 'APERITIVO TIME! Savor a tramezzino and a spritz at Bar Nazionale'
);

Mission m6 = Mission(
  name: 'antiquariato', 
  id: 6, 
  coordinates: LatLng(45.543314773221404, 11.787122058703522),
  type: 1, 
  description: 'Take a stroll through the antique market in Piazzola on the last Sunday of the month: discover the oldest item you can find!'
);

Mission m7 = Mission(
  name: 'artPiazzola', 
  id: 7, 
  coordinates: LatLng(45.543314773221404, 11.787122058703522), 
  type: 2, 
  description: 'Try to find all the modern statues by local artists hidden in various corners of the city.'
);


Map<int, Mission> missionsDatabase = {
  m1.id : m1,
  m2.id : m2,
  m3.id : m3,
  m4.id : m4,
  m5.id : m5,
  m6.id : m6,
  m7.id : m7,
};



