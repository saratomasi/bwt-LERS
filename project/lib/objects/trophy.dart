import 'package:flutter/material.dart';

class Trophy {
  final String name;
  final TrophyType type;
  final int target;
  final String unlockedImage;
  final String lockedImage;
  bool unlocked;
  double progress;

  Trophy({
    required this.name,
    required this.type,
    required this.target,
    this.unlocked = false,
    this.progress = 0.0,
    this.lockedImage = 'lib/assets/trophy_locked.png',
    this.unlockedImage = 'lib/assets/trophy.png',
  });
}

enum TrophyType { 
  kmlength, 
  paths, 
  nature,
  history, 
  art, 
  food, 
  local, 
  missionNature,
  missionHistory, 
  missionArt, 
  missionFood, 
  missionLocal
}