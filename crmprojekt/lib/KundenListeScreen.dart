/*import 'package:flutter/material.dart';
import 'Kunde.dart';
import 'Filiale.dart';
import 'KundenHinzufuegenPage.dart';
import 'Bezirk.dart';



class KundenListeScreen extends StatelessWidget {
  final Filiale filiale;
  final Bezirk bezirk;
  KundenListeScreen({required this.filiale,required this.bezirk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${filiale.name} Kunden Liste'),
      ),
      body: Column(
        children: [
          // Hier kannst du die Kundenliste für die ausgewählte Filiale anzeigen
          // Beispiel: KundenListView(kunden: filiale.kunden),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KundenHinzufuegenPage(filiale: filiale,bezirk: bezirk),
                ),
              );
            },
            child: Text('Kunde hinzufügen'),
          ),
        ],
      ),
    );
  }
}
*/