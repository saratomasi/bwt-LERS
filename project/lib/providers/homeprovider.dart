import 'package:flutter/material.dart';
import 'package:project/models/heartrate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/utils/impact.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  List<HR> heartRates = [];
  String nick = 'User';
  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // data generators from external services
  final Impact impact = Impact();

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider() {
    getDataOfDay(showDate);
  }

  // method to get the data of the chosen day
  void getDataOfDay(DateTime showDate) async {
    showDate = DateUtils.dateOnly(showDate);
    this.showDate = showDate;
    _loading(); // method to give a loading ui feedback to the user
    heartRates = await impact.getDataFromDay(showDate);
    
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  void _loading() {
    heartRates = [];
    notifyListeners();
  }
}