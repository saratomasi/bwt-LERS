import 'package:flutter/material.dart';
import 'package:project/objects/pointOfInterest.dart';
import 'package:project/objects/trail.dart';
import 'package:project/database/pois.dart';

int id1 = 1;
Trail trail1 = Trail(name: 'CamminoSantAntonio', pois: [poisDatabase[1]], level: 2, lengthKm: 24, walkingTime: 7*60,);
int id2 = 2;
List<int> idPois = [2,3];
Trail trail2 = Trail(name: 'PiazzadellaFrutta_PiazzadeiSignori_anellodaSantaRita', pois: [poisDatabase[2], poisDatabase[3]], level: 1, lengthKm: 5.91, walkingTime: 91,);

Map<int,Trail> trailsDatabase = {
  id1 : trail1,
  id2 : trail2,
};

