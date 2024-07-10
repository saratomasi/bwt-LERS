
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/providers/mission_provider.dart';
import 'package:project/objects/mission.dart';
import 'package:project/database/missions_database.dart';

class MissionPage extends StatefulWidget {
  final List<int> missionIds;

  MissionPage({required this.missionIds});

  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {

  late List<Mission> missions;
  
  @override
  void initState() {
    super.initState();
    if (widget.missionIds.isNotEmpty) {
      print(widget.missionIds);
      missions = widget.missionIds.map((id) => missionsDatabase[id]!).toList();
    } else {
      missions = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final missionProvider = Provider.of<MissionProvider>(context);
    final sharedPreferences = Provider.of<SharedPreferences>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mission List'),
      ),
      body: missions.isEmpty
          ? const Center(
              child: Text(
                'No missions available for this trail at the moment.',
              ),
            )
      
      : ListView.builder(
        itemCount: missions.length,
        itemBuilder: (context, index) {
          Mission mission = missions[index];
          return ChangeNotifierProvider.value(
            value: mission, // Passa l'istanza di Mission come valore
            child: Consumer<Mission>(
              builder: (context, mission, _) => Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(mission.imagePath),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mission.description,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Text('You can find it here'),
                                    Icon(Icons.arrow_downward),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              mission.isDone ? Icons.task_alt_rounded : Icons.add_task_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              missionProvider.toggleMissionCompletion(mission.id);
                              missionProvider.saveMissionsToPrefs(sharedPreferences);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(mission.isDone ? 'Marked as done' : 'Marked as not done'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    missionProvider.toggleMissionCompletion(mission.id);
                                    missionProvider.saveMissionsToPrefs(sharedPreferences);
                                  },
                                ),
                              ));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: mission.coordinates,
                            initialRotation: 18.0,
                            interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: mission.coordinates,
                                  width: 80,
                                  height: 80,
                                  child: Icon(Icons.location_on, size: 40, color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
