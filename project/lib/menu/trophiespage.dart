import 'package:flutter/material.dart';
import 'package:project/providers/mission_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/database/trophies_database.dart';
import 'package:project/database/missions_database.dart';
import 'package:project/objects/mission.dart';
import 'package:project/objects/trail.dart';
import 'package:project/objects/trophy.dart';
import 'package:project/providers/trailstate.dart';

class TrophiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: Text('My Achievements'),
      ),
      body: Consumer2<TrailState, MissionProvider>(
        builder: (context, trailState, missionProvider, child) {
          // Aggiorna i progressi dei trofei
          List<Mission> completedMissions = missionsDatabase.values.where((mission) {
            return missionProvider.missions.any((completedMission) => completedMission.id == mission.id && completedMission.isDone);
          }).toList();
          updateTrophyProgress(trophiesDatabase, trailState.doneTrails, trailState.allTrails, completedMissions,); // Passiamo le missioni dal MissionProvider);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Explore and Achieve: \n Your Trophy Collection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: trophiesDatabase.length,
                    itemBuilder: (context, index) {
                      final trophy = trophiesDatabase[index];
                      return TrophyWidget(trophy: trophy);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void updateTrophyProgress(
  List<Trophy> trophies,
  List<Trail> doneTrails,
  List<Trail> allTrails,
  List<Mission> doneMissions,
) {
  int completedTrails = doneTrails.length;
  double totalKm = doneTrails.fold(0.0, (sum, trail) => sum + (trail.lengthKm ?? 0.0));
  List<int> typeCounters = [0, 0, 0, 0, 0]; // Array of counters for each type of trail (from 1 to 5)

  // Count trails by type
  for (var trail in doneTrails) {
    int type = trail.type;
    if (type >= 1 && type <= 5) {
      typeCounters[type - 1]++;
    }
  }

  for (var trophy in trophies) {
    if (trophy.type == TrophyType.paths) {
      trophy.progress = (completedTrails / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.kmlength) {
      trophy.progress = (totalKm / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.nature) {
      trophy.progress = (typeCounters[0] / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.history) {
      trophy.progress = (typeCounters[1] / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.art) {
      trophy.progress = (typeCounters[2] / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.food) {
      trophy.progress = (typeCounters[3] / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.local) {
      trophy.progress = (typeCounters[4] / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.missionNature) { // Aggiornamento per trofei di missioni
      trophy.progress = (doneMissions.where((mission) => mission.type == 0).length / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.missionHistory) {
      trophy.progress = (doneMissions.where((mission) => mission.type == 1).length / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.missionArt) {
      trophy.progress = (doneMissions.where((mission) => mission.type == 2).length / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.missionFood) {
      trophy.progress = (doneMissions.where((mission) => mission.type == 3).length / trophy.target).clamp(0.0, 1.0);
    } else if (trophy.type == TrophyType.missionLocal) {
      trophy.progress = (doneMissions.where((mission) => mission.type == 4).length / trophy.target).clamp(0.0, 1.0);
    }

    trophy.unlocked = trophy.progress >= 1.0;
    if (trophy.unlocked) {
      trophy.progress = 1.0;
    }
  }
}


class TrophyWidget extends StatelessWidget {
  final Trophy trophy;

  const TrophyWidget({Key? key, required this.trophy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            trophy.unlocked ? trophy.unlockedImage : trophy.lockedImage,
            width: 100,
            height: 100,
          ),
          SizedBox(height: 8),
          Text(
            trophy.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: trophy.progress,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(
              trophy.progress >= 1.0 ? Colors.green : Colors.blue, // Cambia colore quando raggiunge il massimo
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${(trophy.progress * 100).toStringAsFixed(0)}%',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
