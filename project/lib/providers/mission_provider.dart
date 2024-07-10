import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/objects/mission.dart';
import 'dart:convert';

class MissionProvider with ChangeNotifier {
  List<Mission> missions;

  MissionProvider({required this.missions});

  void toggleMissionCompletion(int id) {
    Mission mission = missions.firstWhere((m) => m.id == id);
    mission.toggleDone(); // Utilizza il metodo di Mission per cambiare lo stato di isDone
    notifyListeners(); // Notifica i cambiamenti agli ascoltatori (UI)
  }
  void updateMissionsFromPrefs(SharedPreferences prefs) {
    String? savedMissions = prefs.getString('missions');
    if (savedMissions != null) {
      Map<String, dynamic> missionMap = json.decode(savedMissions);
      for (var mission in missions) {
        if (missionMap.containsKey(mission.id.toString())) {
          Mission savedMission = Mission.fromJson(missionMap[mission.id.toString()]);
          mission.isDone = savedMission.isDone;
        }
      }
      notifyListeners();
    }
  }

  Future<void> saveMissionsToPrefs(SharedPreferences prefs) async {
    Map<String, dynamic> serializedMissions = {};
    for (var mission in missions) {
      serializedMissions[mission.id.toString()] = mission.toJson();
    }
    await prefs.setString('missions', json.encode(serializedMissions));
  }
}
