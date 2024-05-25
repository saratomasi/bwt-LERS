import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/bottomnavigationpage.dart';
import'package:shared_preferences/shared_preferences.dart'; 

class Questionnaire extends StatefulWidget {
  @override
  _Questionnaire createState() => _Questionnaire();
}

class _Questionnaire extends State<Questionnaire> {
  String _nome = '';
  String _cognome = '';
  int eta = 0 ;
  String _sede = '';
  String _allenaSettimana = '';
  String _avatar = '';

  final List<String> sedi = ['Padova'];
  //final List<String> eta = ['16/30 anni', '30/50 anni', '50/60 anni', '+60 anni'];
  final List<String> frequenzaAllenamento = ['Nessun allenamento', '1-2 volte alla settimana', '3+ volte alla settimana'];
  final List<String> avatars = [
    'lib/assets/avatar1.png', 
    'lib/assets/avatar2.png', 
    'lib/assets/avatar3.png',
    'lib/assets/avatar4.png'
  ];
  final List<String> nomi_avatar = ['Fuoco','Acqua','Aria','Terra'];
  

  bool get isWarningVisible => _nome.isNotEmpty && _cognome.isNotEmpty && eta!=0 && _sede.isNotEmpty && _allenaSettimana.isNotEmpty && _avatar.isNotEmpty;
   Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', _nome);
    prefs.setString('cognome', _cognome);
    prefs.setInt('eta', eta);
    prefs.setString('sede', _sede);
    prefs.setString('frequenzaAllenamento', _allenaSettimana);
    prefs.setString('avatar', _avatar);
  }

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionario'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (value) {
                    setState(() {
                      _nome = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Cognome'),
                  onChanged: (value) {
                    setState(() {
                      _cognome = value;
                    });
                  },
                ),
                // DropdownButtonFormField<String>(
                //   value: _eta.isEmpty ? null : _eta,
                //   onChanged: (value) {
                //     setState(() {
                //       _eta = value!;
                //     });
                //   },
                //   items: eta.map((eta) {
                //     return DropdownMenuItem(
                //       value: eta,
                //       child: Text(eta),
                //     );
                //   }).toList(),
                //   decoration: InputDecoration(labelText: 'Età'),
                // ),

                // MODIFICATO IL CAMPO ETA' METTENDO DEI CONSTRAINTS ALLA TASTIERA
                   TextField(
                  decoration: InputDecoration(labelText: 'Età'),
                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2)],
                  onChanged: (value) {
                    setState(() {
                      eta = int.parse(value) ;
                    });
                  },
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
                  decoration: InputDecoration(labelText: 'Sede'),
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
                  decoration: InputDecoration(labelText: 'Frequenza allenamento'),
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
                    'Si prega di compilare tutti i campi',
                    style: TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (isWarningVisible) {
                      saveData();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNavigationBarPage()),
                      );
                    }
                  },
                  child: Text('Invia'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}