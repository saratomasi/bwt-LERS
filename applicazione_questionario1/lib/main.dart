import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = '';
  String _cognome = '';
  String _eta = '';
  String _sede = '';
  String _allenaSettimana = '';
  String _avatar = '';

  final List<String> sedi = ['Padova', 'Vicenza'];
  final List<String> eta = ['16/30 anni', '30/50 anni', '50/60 anni', '+60 anni'];
  final List<String> frequenzaAllenamento = ['Nessun allenamento', '1-2 volte alla settimana', '3+ volte alla settimana'];
  final List<String> avatars = [
    'https://example.com/avatar1.jpg', // URL dell'immagine per Avatar 1
    'https://example.com/avatar2.jpg', // URL dell'immagine per Avatar 2
    'https://example.com/avatar3.jpg', // URL dell'immagine per Avatar 3
  ];

  bool get isWarningVisible => _nome.isNotEmpty && _cognome.isNotEmpty && _eta.isNotEmpty && _sede.isNotEmpty && _allenaSettimana.isNotEmpty;
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionario'),
      ),
      body: Padding(
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
              DropdownButtonFormField<String>(
                value: _eta.isEmpty ? null : _eta,
                onChanged: (value) {
                  setState(() {
                    _eta = value!;
                  });
                },
                items: eta.map((eta) {
                  return DropdownMenuItem(
                    value: eta,
                    child: Text(eta),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Età'),
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
                items: avatars.map((avatar) {
                  return DropdownMenuItem(
                    value: avatar,
                    child: Row(
                      children: [
                        Image.network(
                          avatar,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text('Avatar'),
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
                  // Eseguire azione al click del pulsante, ad esempio salvare i dati
                  print('Nome: $_nome');
                  print('Cognome: $_cognome');
                  print('Età: $_eta');
                  print('Sede: $_sede');
                  print('Frequenza allenamento: $_allenaSettimana');
                  print('Avatar: $_avatar');
                },
                child: Text('Invia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
