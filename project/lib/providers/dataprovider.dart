import 'package:flutter/material.dart';
import 'package:project/models/distance.dart';
import 'package:project/models/heartrate.dart';
import 'package:project/models/resting_hr.dart';
import 'package:project/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/utils/impact.dart';
import 'package:collection/collection.dart';

class DataProvider extends ChangeNotifier {
  List<HR> heartRates = [];
  List<RHR> resting_hr = [] ;
  List<Steps> steps = [] ;
  List<Distance> distance = [] ;
  //String nick = 'User';
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  final Impact impact = Impact();

  // constructor
  DataProvider() {
    //fetchData(showDate); -> non ci va se vogliamo che il provider funzioni solo premendo il bottone
  }

  Future<void> fetchData(DateTime showDate) async {
    showDate = DateUtils.dateOnly(showDate);
    this.showDate = showDate;
    //_loading(); // method to give a loading ui feedback to the user
    try {
          heartRates = await impact.getHeartRate(showDate);
    resting_hr = await impact.getRestingHeartRate(showDate) ;
    steps = await impact.getSteps(showDate) ;
    distance = await impact.getDistance(showDate) ;

    //print(heartRates) ;
    //print(resting_hr) ;
    //print(distance) ;

    notifyListeners();

    } catch (e) {
      print(e) ;
    }

  }

  // void _loading() {
  //   heartRates = [];
  //   resting_hr = [] ;
  //   notifyListeners();
  // }

  Future<String> getLevel() async {
    String level = '';
    int score = 0;
    final sp = await SharedPreferences.getInstance();
    int? age = sp.getInt('eta');
    String? training = sp.getString('frequenzaAllenamento') ;

    // Do un punteggio per il livello di allenamento selezionato
    if (training == 'No exercise') {
      score = score + 0 ;
    }
    else if (training=='1-2 times per week') {
      score = score + 5 ;
    } else {
      score = score + 10 ;
    }

    // Do un punteggio in base all'età
    if (age! >= 60) {
      score = score + 0 ;
    }
    else if (age < 60 && age >= 45) {
      score = score + 5 ;
    } else {
      score = score + 10 ;
    }

    // Uso age per calcolare la frequenza cardiaca massima (formula aprossimata di Tanaka) e la confronta con l'average heart rate
      int FCmax = 200 - age; // Frequenza cardiaca massima teorica
      List<int> heartRate_values =
          heartRates.map((heartRates) => heartRates.value).toList();
      double heartRate_average = heartRate_values.average;
      if (heartRate_average <= FCmax * 0.6) {
        score = score + 0;
      } else if (heartRate_average > FCmax * 0.6 && heartRate_average <= FCmax * 0.75) {
        score = score + 5;
      } else {
        score = score + 10;
      }

      // VALUTO I PASSI (soglie scelte per valutazione di 3 giorni)
      List<int> steps_values = steps.map((steps)=> (steps.value)).toList() ;
      double steps_average = steps_values.average ;
      if (steps_average <= 15000) {
        score = score + 0 ;
      }
      else if (steps_average >15000 && steps_average < 25000) {
        score = score + 5 ;
      }
      else {
        score= score + 10 ;
      }

      // VALUTO L'HEART RATE MEDIO A RIPOSO
      List<double> resting_values = resting_hr.map((resting_hr)=> resting_hr.value).toList() ;
      double restingHR_average = resting_values.average ;
      if (restingHR_average >= 80) {
        score = score + 0 ;
      }
      else if (restingHR_average < 80 && restingHR_average >= 55) {
        score = score + 5 ;
      }
      else {
        score= score + 10 ;
      }

      // VALUTO LA DISTANZA PERCORSA AL GIORNO
      List<int> distance_values = distance.map((distance)=> distance.value).toList() ;
      List<double> distance_values_km = distance_values.map((distance_values) => distance_values *1e-5).toList();
      double distance_average = distance_values_km.average ;
      if (distance_average <= 5) {
        score = score + 0 ;
      }
      else if (distance_average > 5 && distance_average <= 10) {
        score = score + 5 ;
      }
      else {
        score= score + 10 ;
      }

      print(score) ;

      // Calcolo finale del livello
      if (score < 20) {
        level = 'Beginner';
      } else if (score >=20 && score < 40) {
        level = 'Intermediate';
      } else {
        level = 'Expert';
      }

      // Salvo in SharedPreferences il livello
      sp.setString('level', level);
      return level;
    }
  }
//}

// Quindi in teoria su getDataOfDay inserisco la data corrente - 1 (quindi la data di ieri) e su impact la prende come END,
// mentre lo START è pari a END-7 (per ora)






// data for achievements

class AchievementsProvider with ChangeNotifier {
  List<Achievement> _achievements = [];

  List<Achievement> get achievements => _achievements;

  void addAchievement(Achievement achievement) {
    _achievements.add(achievement);
    notifyListeners();
  }

  void updateAchievement(int index, double progress) {
    _achievements[index].progress = progress;
    notifyListeners();
  }

  double get totalProgress {
    if (_achievements.isEmpty) return 0;
    double total = _achievements.fold(0, (sum, item) => sum + item.progress);
    return total / _achievements.length;
  }
}

class Achievement {
  String title;
  double progress;

  Achievement({required this.title, this.progress = 0});
}
