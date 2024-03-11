// FilialeScreen.dart
import 'package:flutter/material.dart';
import 'Filiale.dart';
import 'KundenHinzufuegenPage.dart';
import 'KundenListePage.dart';
import 'Bezirk.dart';

class FilialeScreen extends StatelessWidget {
  final Filiale filiale;
  final Bezirk bezirk;

  FilialeScreen({required this.filiale,required this.bezirk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${filiale.name} - CRM',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Hintergrundfarbe der AppBar ändern
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... (anderer Bildschirminhalt)
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KundenListePage(filiale: filiale,bezirk: bezirk),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, 
                onPrimary: Colors.white, 
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
              child: Text(
                'Zur Kundenliste',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}