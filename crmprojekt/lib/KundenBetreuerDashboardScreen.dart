import 'package:flutter/material.dart';
import 'Bezirk.dart';
import 'dashboard_link_widget.dart';
import 'BezirkListScreen.dart';
import 'Filiale.dart';
import 'KontaktHistoryPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EmailVersandListPage.dart';

import 'Geburtsdatum.dart';

class KundenBetreuerDashboardScreen extends StatelessWidget {
  final List<Bezirk> bezirke;

  KundenBetreuerDashboardScreen({required this.bezirke});
  Future<List<Filiale>> fetchFilialen() async {
  final response = await http.get(Uri.parse('http://localhost:8080/api/filialen'));

  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    List<Filiale> filialen = responseData.map((filialeData) => Filiale.fromJson(filialeData)).toList();
    return filialen;
  } else {
    throw Exception('Failed to load filialen');
  }
}


  @override
   Widget build(BuildContext context) {
    // Beispiel-Bezirke
    List<Bezirk> bezirke = [
      Bezirk(id:10,name: 'Bezirk Süd', filialen: []),
      Bezirk(id:20,name: 'Bezirk Südwest', filialen: []),
      Bezirk(id:30,name: 'Bezirk Mitte', filialen: [Filiale(id:10,name: 'Filiale Darmstadt', bezirk: Bezirk(id:30,name: 'Bezirk Mitte', filialen: []),kunden:[]), Filiale(id: 20,name: 'Filiale Frankfurt', bezirk: Bezirk(id:30,name: 'Bezirk Mitte', filialen: []),kunden:[]),
       Filiale(id:30, name: 'Filiale Mainz', bezirk: Bezirk(id: 30,name: 'Bezirk Mitte', filialen: []),kunden: []), Filiale(id:40, name: 'Filiale Wiesbaden', bezirk: Bezirk(id:30,name: 'Bezirk Mitte', filialen: []),kunden: [])]),
      Bezirk(id:40,name: 'Bezirk Nord', filialen: []),
      Bezirk(id:50,name: 'Bezirk West', filialen: []),
      Bezirk(id:60,name: 'Bezirk Nordwest', filialen: []),
      Bezirk(id:70,name: 'Bezirk Ost', filialen: []),
    ];
 



    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRM Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/CRM.jpg',
                  width: 150.0,
                  height: 150.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Schnelle Links:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 10.0),
              Column(
                children: bezirke.map((bezirk) {
                  return DashboardLinkWidget(
                    title: bezirk.name,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BezirkListScreen(bezirk: bezirk),
                        ),
                        
                      );
                    },
                  );
                }).toList(),
             
              ),
               SizedBox(height: 20),

              // Kontakt History button
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KontaktHistoryPage()),
        );
      },
      child: Text('Kontaktverlauf'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
      ),
    ),
    ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmailVersandListPage()),
        );
      },
      child: Text('Email Versand'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button color
        onPrimary: Colors.white, // Text color
      ),
    ),
    ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GeburtsdatumPage()),
        );
      },
      child: Text('Geburstdatum'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button color
        onPrimary: Colors.white, // Text color
      ),
    ),
  
    
  ],
)

            ],
          ),
        ),
      ),
    );
  }
}
           