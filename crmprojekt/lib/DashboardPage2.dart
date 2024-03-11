import 'Listofbenutzer2.dart';
import 'package:flutter/material.dart';

class DashboardPage2 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

  final String loggedInUsername = args['loggedInUsername'];
  print('Erstelle die Dashboard-Seite mit der Benutzername: $loggedInUsername');

  return Scaffold(
    appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 78, 230),
        title: Text(
          //'Startseite - $loggedInUsername',
          'Dashboard-Seite ',
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
  'Herzlich willkommen zurück bei CustomerConnect, $loggedInUsername',
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Listofbenutzer2())); },
        style: ElevatedButton.styleFrom(
        primary: Colors.blue, 
        onPrimary: Colors.white, 
        padding: EdgeInsets.all(15.0), 
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Text('Kundenbetreuer'),
),


ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/Rejectedusers2');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.green, 
    onPrimary: Colors.white,
    padding: EdgeInsets.all(15.0), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Text('Abgelehnte Kundenbetreuer'),
),


ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/Useranlegen2');
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.green, 
    onPrimary: Colors.white,
    padding: EdgeInsets.all(15.0), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  child: Text('Neuen Kundenbetreuer anlegen'),
),


ElevatedButton(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/login');},
 
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
