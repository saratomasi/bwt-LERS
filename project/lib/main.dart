import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/splash.dart';
import 'package:project/providers/trailstate.dart';
import 'package:project/providers/mission_provider.dart';
import 'package:project/database/missions_database.dart';
import 'package:project/objects/mission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Initialize SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get missions from the database
  List<Mission> missions = missionsDatabase.values.toList();
  MissionProvider missionProvider = MissionProvider(missions: missions);
  missionProvider.updateMissionsFromPrefs(prefs);

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<SharedPreferences>(
          create: (_) => SharedPreferences.getInstance(),
          initialData: prefs,
        ), // Provide SharedPreferences as a FutureProvider
        ChangeNotifierProvider(create: (_) => TrailState()),
        ChangeNotifierProvider.value(value: missionProvider), // Use ChangeNotifierProvider.value for existing instances
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
