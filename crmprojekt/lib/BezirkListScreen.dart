// BezirkListScreen.dart
import 'package:flutter/material.dart';
import 'FilialeScreen.dart';
import 'Filiale.dart';
import 'Bezirk.dart';
import 'KundenHinzufuegenPage.dart';
import 'KundenListeScreen.dart';

class BezirkListScreen extends StatelessWidget {
  final Bezirk bezirk;

  BezirkListScreen({required this.bezirk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bezirk.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Hintergrundfarbe der AppBar ändern
      ),
      body: ListView.builder(
        itemCount: bezirk.filialen.length,
        itemBuilder: (context, index) {
          var filiale = bezirk.filialen[index];
          return ListTile(
            title: Text(filiale.name),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilialeScreen(filiale: filiale,bezirk: bezirk),
                ),
              );
            },
            // Weitere Details oder Aktionen für jede Filiale hinzufügen
          );
        },
      ),
    );
  }
}