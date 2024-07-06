import 'package:flutter/material.dart';
import 'package:project/objects/trail.dart';
import 'package:project/database/trailsDatabase.dart';

class TrailState extends ChangeNotifier {

  List<Trail> _filteredTrails = [];

  void toggleDone(int id) {
    trailsDatabase[id]?.isDone = !(trailsDatabase[id]?.isDone ?? false);
    notifyListeners();
  }

  void toggleFavorite(int id) {
    trailsDatabase[id]?.isFavorite = !(trailsDatabase[id]?.isFavorite ?? false);
    notifyListeners();
  }

  void toggleSaved(int id) {
    trailsDatabase[id]?.isSaved = !(trailsDatabase[id]?.isSaved ?? false);
    notifyListeners();
  }

  void updateTrail(Trail updatedTrail) {
    if (trailsDatabase.containsKey(updatedTrail.id)) {
      trailsDatabase[updatedTrail.id] = updatedTrail;
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
