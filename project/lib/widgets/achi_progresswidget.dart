import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AchievementProgressWidget extends StatelessWidget {
  final String title;
  final int goal;
  final double currentProgress;

  AchievementProgressWidget({
    required this.title,
    required this.goal,
    required this.currentProgress,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = currentProgress / goal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$title: ${currentProgress.toInt()} / $goal',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 10.0,
          percent: percentage,
          center: Text(
            '${(percentage * 100).toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 12.0),
          ),
          progressColor: Colors.blue,
        ),
        SizedBox(height: 20), // Spazio tra gli indicatori
      ],
    );
  }
}
