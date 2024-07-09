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
    required this.unlockedImage,
    required this.lockedImage,
    this.unlocked = false,
    this.progress = 0.0,
  });
}

enum TrophyType { steps, paths, /* pointsOfInterest, */ level }

class TrophiesNotifier with ChangeNotifier {
  final List<Trophy> _trophies = [
    Trophy(
      name: '10 000 steps',
      type: TrophyType.steps,
      target: 10000,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    Trophy(
      name: '50 000 steps',
      type: TrophyType.steps,
      target: 50000,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    Trophy(
      name: '100 000 steps',
      type: TrophyType.steps,
      target: 100000,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    Trophy(
      name: '1st path done!',
      type: TrophyType.paths,
      target: 1,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    Trophy(
      name: '5 paths done!',
      type: TrophyType.paths,
      target: 5,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    Trophy(
      name: '10 paths done!',
      type: TrophyType.paths,
      target: 10,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),

    /* Trophy(
      name: '10 places of interest visited!',
      type: TrophyType.pointsOfInterest,
      target: 10,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ), */
    
    Trophy(
      name: 'Congratulations! You moved to the next level',
      type: TrophyType.level,
      target: 1,
      unlockedImage: 'lib/assets/trophy.png',
      lockedImage: 'lib/assets/trophy_locked.png',
    ),
  ];

  List<Trophy> get trophies => _trophies;

  void unlockTrophy(String trophyName, BuildContext context) {
    for (var trophy in trophies) {
      if (trophy.name == trophyName && !trophy.unlocked) {
        trophy.unlocked = true;
        notifyListeners();
        _showCongratulationsDialog(context, trophy.name);
      }
    }
  }

  void _showCongratulationsDialog(BuildContext context, String trophyName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You have a new trophy unlocked: $trophyName'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateProgress(String trophyName, double progress) {
    for (var trophy in _trophies) {
      if (trophy.name == trophyName) {
        trophy.progress = progress;
        notifyListeners();
      }
    }
  }

  void checkObjectives(
    TrophiesNotifier trophiesNotifier,
    int steps,
    int paths,
    int pointsOfInterest,
    String level,
    BuildContext context,
  ) {
    if (steps >= 100000) {
      trophiesNotifier.unlockTrophy('100 000 steps!', context);
    }
    if (paths >= 10) {
      trophiesNotifier.unlockTrophy('10 paths done!', context);
    }
    if (pointsOfInterest >= 10) {
      trophiesNotifier.unlockTrophy('10 places of interest visited!', context);
    }
    
    double progress50kSteps = steps / 50000;
    double progress100kSteps = steps / 100000;
    
    trophiesNotifier.updateProgress('50 000 steps!', progress50kSteps);
    trophiesNotifier.updateProgress('100 000 steps!', progress100kSteps);
  }
}
