import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/dataprovider.dart';

/*class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: PieChart(
        PieChartData(
          sections: getSections(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 40,
        title: '40%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 20,
        title: '20%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.yellow,
        value: 10,
        title: '10%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}*/



class AchievementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var achievementsProvider = Provider.of<AchievementsProvider>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: achievementsProvider.achievements.length,
        itemBuilder: (context, index) {
          var achievement = achievementsProvider.achievements[index];
          return ListTile(
            title: Text(achievement.title),
            subtitle: LinearProgressIndicator(value: achievement.progress),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    double progress = achievement.progress;
                    return AlertDialog(
                      title: Text('Update Achievement'),
                      content: Slider(
                        value: progress,
                        onChanged: (value) {
                          progress = value;
                        },
                        min: 0,
                        max: 1,
                        divisions: 100,
                        label: '${(progress * 100).round()}%',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            achievementsProvider.updateAchievement(index, progress);
                            Navigator.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}