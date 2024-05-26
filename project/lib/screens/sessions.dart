import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SessionsPage extends StatelessWidget{
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sessions'),
      ),
      body: Column(
        children:[
          searchBar(), // Barra di ricerca dei percorsi
          Expanded(child: mapView()), // Mappa di riepilogo
          Expanded(flex: 3, child: sessionList(),), // Elenco delle sessioni
        ],
      )
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Session',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value){
        //logica di ricerca qui
        },
      ),
    );
  }

  Widget mapView() {
    return const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(45.4642, 9.1900), // Posizione di esempio
          zoom: 12,
        ),
        markers: {
        // Aggiungi i marker per ogni percorso completato
        },
      );
  }

  Widget sessionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text('Percorso ${index + 1}'),
            subtitle: Text('Dettagli del percorso ${index + 1}'),
            onTap: () {
            // Implementa la navigazione ai dettagli del percorso
            },
          ),
        );
      },
    );
  }
}
      
      /*body: Column(
        children: [
          //search bar
          
          const Expanded(
            flex: 3,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('My Maps'),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 10, // provvisorio
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text('Percorso ${index + 1}'),
                    subtitle: Text('Dettagli del percorso ${index + 1}'),
                    onTap: () {
                      // Implementa la navigazione ai dettagli del percorso
                    },
                  ),
                );
              },
            ),
          ),
        ]
      )
    );
  }
}**/

/*
return ListView.builder(
    itemCount: sessions.length,
    itemBuilder: (context, index) {
      Session session = sessions[index];
      return Card(
        child: ListTile(
          title: Text('${session.date} - ${session.time}'),
          subtitle: Text('Distanza: ${session.distance} km'),
          trailing: Icon(Icons.arrow_forward),
        ),
        onTap: () {
          // Naviga alla pagina dei dettagli della sessione
        },
      );
    },
  );**/