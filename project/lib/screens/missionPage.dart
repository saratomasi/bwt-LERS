import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/objects/mission.dart';

class MissionPage extends StatefulWidget {
  final List<Mission> missions;

  MissionPage({required this.missions});

  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _toggleMissionCompletion(int index) {
    setState(() {
      widget.missions[index].isDone = !widget.missions[index].isDone;
    });

    // Save mission completion status
    _saveMissions();
    //notifyListeners();
    
    // Show snackbar
    _showUndoSnackbar(context, widget.missions[index].isDone ? 'Marked as done' : 'Marked as not done', () {
      setState(() {
        widget.missions[index].isDone = !widget.missions[index].isDone;
      });
      _saveMissions(); // Undo action, revert state
      //notifyListeners();
    });
  }

  Future<void> _saveMissions() async {
    if (prefs != null) {
      Map<String, dynamic> serializedMissions = {};
      widget.missions.forEach((mission) {
        serializedMissions[mission.id.toString()] = mission.toJson();
      });
      await prefs!.setString('missions', json.encode(serializedMissions));
    }
  }

  void _showUndoSnackbar(BuildContext context, String message, VoidCallback undoAction) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: undoAction,
      ),
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission List'),
      ),
      body: ListView.builder(
        itemCount: widget.missions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(widget.missions[index].imagePath),
              ),
              title: Text(widget.missions[index].description),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('You can start from here'),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: widget.missions[index].coordinates,
                        initialZoom: 18.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: widget.missions[index].coordinates,
                              width: 80, 
                              height: 80, 
                              child: Icon(Icons.location_on),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  widget.missions[index].isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _toggleMissionCompletion(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}