import 'Listofbenutzer1.dart';
import 'package:flutter/material.dart';
import 'KundenBetreuerDashboardScreen.dart';

class Kundebetreuer extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {


  return Scaffold(
    appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 78, 230),
        title: Text(
          'Startseite ',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 153, 37),
            fontSize: 24.0, 
          ),
        ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
  'Willkommen zurück bei VisionaryCRM, Kundebetreuer',
  style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue, 
  ),
),

          //Text('Welcome Back  TO VisionaryCRM , ${loggedInUsername != null ? loggedInUsername.toLowerCase() : ''}!'),
          //if (loggedInUsername != null && (loggedInUsername.toLowerCase() == 'admin1' || loggedInUsername.toLowerCase() == 'admin2'))
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => KundenBetreuerDashboardScreen(bezirke: [],)));
                            },
        style: ElevatedButton.styleFrom(
       primary: Colors.blue, 
       onPrimary: Colors.white, 
      padding: EdgeInsets.all(15.0), 
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Text('Liste der Kunden'),
),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/passwortandern');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.green, 
    onPrimary: Colors.white,
    padding: EdgeInsets.all(15.0), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Text('Passwort ändern'),
),

ElevatedButton(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/login');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.red,
    onPrimary: Colors.white, 
    padding: EdgeInsets.all(15.0), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),
  ),
  child: Text('Abmelden'),
),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
}