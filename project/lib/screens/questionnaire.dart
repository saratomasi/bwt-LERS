import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/bottomnavigationpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  String _nome = '';
  String _cognome = '';
  int eta = 0;
  String _sede = '';
  String _allenaSettimana = '';
  String _avatar = '';
  String _livelloProvvisorio = '';

  final List<String> sedi = ['Padova'];
  final List<String> frequenzaAllenamento = ['No exercise', '1-2 times per week', '3 or more times per week'];
  final List<String> avatars = [
    'lib/assets/avatar1.png',
    'lib/assets/avatar2.png',
    'lib/assets/avatar3.png',
    'lib/assets/avatar4.png'
  ];
  final List<String> nomi_avatar = ['Fire', 'Water', 'Air', 'Earth'];

  bool get isWarningVisible =>
      _nome.isNotEmpty &&
      _cognome.isNotEmpty &&
      eta >= 8 &&
      eta <= 100 &&
      _sede.isNotEmpty &&
      _allenaSettimana.isNotEmpty &&
      _avatar.isNotEmpty;

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', _nome);
    prefs.setString('cognome', _cognome);
    prefs.setInt('eta', eta);
    prefs.setString('sede', _sede);
    prefs.setString('frequenzaAllenamento', _allenaSettimana);
    prefs.setString('avatar', _avatar);
    prefs.setString('livelloProvvisorio', _livelloProvvisorio); // Save provisional level
  }

  void calculateProvisionalLevel() {
    int score = 0;

    if (_allenaSettimana == 'No exercise') {
      score += 0;
    } else if (_allenaSettimana == '1-2 times per week') {
      score += 5;
    } else {
      score += 10;
    }

    if (eta >= 60) {
      score += 0;
    } else if (eta < 60 && eta >= 35) {
      score += 5;
    } else {
      score += 10;
    }

    if (score < 10) {
      _livelloProvvisorio = 'Beginner';
    } else if (score >= 10 && score < 20) {
      _livelloProvvisorio = 'Intermediate';
    } else {
      _livelloProvvisorio = 'Expert';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      _nome = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Surname'),
                  onChanged: (value) {
                    setState(() {
                      _cognome = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2)
                  ],
                  onChanged: (value) {
                    setState(() {
                      eta = int.tryParse(value) ?? 0;
                    });
                  },
                ),
                if (eta != 0 && (eta < 8 || eta > 100))
                  Text(
                    'Unsupported age',
                    style: TextStyle(color: Colors.red),
                  ),
                DropdownButtonFormField<String>(
                  value: _sede.isEmpty ? null : _sede,
                  onChanged: (value) {
                    setState(() {
                      _sede = value!;
                    });
                  },
                  items: sedi.map((sede) {
                    return DropdownMenuItem(
                      value: sede,
                      child: Text(sede),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Location'),
                ),
                DropdownButtonFormField<String>(
                  value: _allenaSettimana.isEmpty ? null : _allenaSettimana,
                  onChanged: (value) {
                    setState(() {
                      _allenaSettimana = value!;
                    });
                  },
                  items: frequenzaAllenamento.map((frequenza) {
                    return DropdownMenuItem(
                      value: frequenza,
                      child: Text(frequenza),
                    );
                  }).toList(),
                  decoration:
                      InputDecoration(labelText: 'How often do you exercise per week?'),
                ),
                DropdownButtonFormField<String>(
                  value: _avatar.isEmpty ? null : _avatar,
                  onChanged: (value) {
                    setState(() {
                      _avatar = value!;
                    });
                  },
                  items: avatars.asMap().entries.map((entry) {
                    int index = entry.key;
                    String avatar = entry.value;
                    return DropdownMenuItem(
                      value: avatar,
                      child: Row(
                        children: [
                          Image.asset(
                            avatar,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 10),
                          Text(nomi_avatar[index]),
                        ],
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Avatar'),
                ),
                if (!isWarningVisible)
                  Text(
                    'Please fill in all fields',
                    style: TextStyle(color: Colors.red),
                  ),
                if (_livelloProvvisorio.isNotEmpty)
                  Text(
                    'Provisional Level: $_livelloProvvisorio',
                    style: TextStyle(color: Colors.blue),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (isWarningVisible) {
                      calculateProvisionalLevel(); // Calculate provisional level
                      saveData(); // Save all data including provisional level
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNavigationBarPage()),
                      );
                    } else {
                      setState(() {});
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}