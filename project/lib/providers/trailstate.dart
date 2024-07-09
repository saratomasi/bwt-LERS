import 'package:flutter/material.dart';
import 'package:project/objects/trail.dart';
import 'package:project/database/trailsDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TrailState extends ChangeNotifier {

  List<Trail> _filteredTrails = [];

  TrailState() {
    _loadTrails();
  }

  Future<void> _loadTrails() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTrails = prefs.getString('trailsDatabase');
    if (savedTrails != null) {
      Map<int, Trail> loadedTrails = Map.from(json.decode(savedTrails).map((key, value) => MapEntry(int.parse(key), Trail.fromJson(value))));
      trailsDatabase.clear();
      trailsDatabase.addAll(loadedTrails);
      notifyListeners();
    }
  }

  Future<void> _saveTrails() async {
  final prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> serializedTrails = {};
  trailsDatabase.forEach((key, trail) {
    serializedTrails[key.toString()] = trail.toJson();
  });
  prefs.setString('trailsDatabase', json.encode(serializedTrails));
}

  Future<void> toggleDone(int id) async {
    trailsDatabase[id]?.isDone = !(trailsDatabase[id]?.isDone ?? false);
    await _saveTrails();
    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    trailsDatabase[id]?.isFavorite = !(trailsDatabase[id]?.isFavorite ?? false);
    await _saveTrails();
    notifyListeners();
  }

  Future<void> toggleSaved(int id) async {
    trailsDatabase[id]?.isSaved = !(trailsDatabase[id]?.isSaved ?? false);
    await _saveTrails();
    notifyListeners();
  }

  void updateTrail(Trail updatedTrail) {
    if (trailsDatabase.containsKey(updatedTrail.id)) {
      trailsDatabase[updatedTrail.id] = updatedTrail;
      _saveTrails();
      notifyListeners();
    }
  }

  //SEARCH METHODS:

  void searchDoneTrails(String query) {
    if (query.isEmpty) {
      _filteredTrails = [];
    } else {
      _filteredTrails = doneTrails
          .where((trail) => trail.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchFavoriteTrails(String query) {
    if (query.isEmpty) {
      _filteredTrails = [];
    } else {
      _filteredTrails = favoriteTrails
          .where((trail) => trail.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchSavedTrails(String query) {
    if (query.isEmpty) {
      _filteredTrails = [];
    } else {
      _filteredTrails = savedTrails
          .where((trail) => trail.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchAllTrails(String query) {
    if (query.isEmpty) {
      _filteredTrails = [];
    } else {
      _filteredTrails = trailsDatabase.values
          .where((trail) => trail.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void searchNotDoneTrails(String query) {
    if (query.isEmpty) {
      _filteredTrails = [];
    } else {
      _filteredTrails = notDoneTrails
          .where((trail) => trail.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _filteredTrails = [];
    notifyListeners();
  }


  //LISTS of filtered trails:

  List<Trail> get doneTrails {
    var trails = _filteredTrails.isEmpty 
        ? trailsDatabase.values
            .where((trail) => trail.isDone)
            .toList()
        : _filteredTrails;

    trails.sort((a, b) => b.date.compareTo(a.date)); // Ordina per data decrescente
    return trails;
  }

  List<Trail> get favoriteTrails {
    return _filteredTrails.isEmpty 
        ? trailsDatabase.values.where((trail) => trail.isFavorite).toList()
        : _filteredTrails;
  }

  List<Trail> get savedTrails {
    return _filteredTrails.isEmpty 
        ? trailsDatabase.values.where((trail) => trail.isSaved).toList()
        : _filteredTrails;
  }

  List<Trail> get allTrails {
    return _filteredTrails.isEmpty 
        ? trailsDatabase.values.toList()
        : _filteredTrails;
  }

  List<Trail> get notDoneTrails {
    return _filteredTrails.isEmpty 
        ? trailsDatabase.values.where((trail) => !trail.isDone).toList()
        : _filteredTrails;
  }
}
