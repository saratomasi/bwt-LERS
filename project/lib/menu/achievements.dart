import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/menu/trophiesnotifier.dart';

class AchievementsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final trophiesNotifier = Provider.of<TrophiesNotifier>(context);
    final progressValues = trophiesNotifier.trophies.map((trophy) => trophy.progress).toList();

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Welcome to the Achievements page!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 19, 150, 45),
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
                itemCount: trophiesNotifier.trophies.length,
                itemBuilder: (context, index) {
                  final trophy = trophiesNotifier.trophies[index];
                  return TrophyWidget(trophy: trophy);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class TrophyWidget extends StatelessWidget {
  final Trophy trophy;

  TrophyWidget({required this.trophy});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            trophy.unlocked
                ? trophy.unlockedImage
                : trophy.lockedImage,
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
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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