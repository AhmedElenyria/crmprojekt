import 'package:flutter/material.dart';
import 'KundenHinzufuegenPage.dart';
import 'KundenBetreuerDashboardScreen.dart';
import 'BezirkListScreen.dart';
import 'KundenListePage.dart';

import 'Bezirk.dart';
import 'FilialeScreen.dart';
import 'Filiale.dart';
import 'LoginPage.dart';
import 'DashboardPage1.dart';
import 'DashboardPage2.dart';
import 'Listofbenutzer1.dart';
import 'Listofbenutzer2.dart';
import 'Useranlegen1.dart';
import 'Useranlegen2.dart';
import 'Rejectedusers1.dart';
import 'Rejectedusers2.dart';
import 'Kundebetreuer.dart';
import 'neuespasswort.dart';
import 'Passwortablauf.dart';
import 'passwortandern.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Bezirk get defaultBezirk => Bezirk(id: 30, name: "Bezirk Mitte", filialen:[]);
  Filiale get defaultFiliale => Filiale(id: 10, name: 'Filiale Darmstadt', bezirk: Bezirk(id:30,name: 'Bezirk Mitte', filialen: []),kunden:[]);

  @override
  Widget build(BuildContext context) {

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

    return MaterialApp(
       title: 'CustomerConnect ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/kundenBetreuerDashboard': (context) => KundenBetreuerDashboardScreen(bezirke: bezirke),
        '/bezirk': (context) => BezirkListScreen(bezirk: bezirke[4]),
        'filiale': (context) => FilialeScreen(filiale: defaultFiliale,bezirk: defaultBezirk),
        '/kundenListe': (context) => KundenListePage(filiale: defaultFiliale,bezirk: defaultBezirk),
        '/kundenHinzufuegen' :(context) => KundenHinzufuegenPage(filiale: defaultFiliale,bezirk: defaultBezirk),
         '/Kundebetreuer':(context)=>Kundebetreuer(),
         '/DashboardPage1': (context) => DashboardPage1(),
         '/DashboardPage2': (context) => DashboardPage2(),
         '/Useranlegen1': (context)=>Useranlegen1(),
         '/Useranlegen2': (context)=>Useranlegen2(),
         '/Listofbenutzer1': (context)=>Listofbenutzer1(),
         '/Listofbenutzer2': (context)=>Listofbenutzer2(),
         '/Rejectedusers1':(context)=>Rejectedusers1(),
         '/Rejectedusers2':(context)=>Rejectedusers2(),
         '/neuespasswort':(context)=>neuespasswort(),
         '/passwortandern':(context)=>passwortandern(),
         '/Passwortablauf':(context)=>Passwortablauf(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/filiale')  {
       
          final arguments = settings.arguments;
          if (arguments is Filiale) {
            Bezirk associatedBezirk = arguments.bezirk;
            return MaterialPageRoute(
              builder: (context) => FilialeScreen(filiale: arguments,bezirk: associatedBezirk),
            );
          }
        }
        
      },
    );


  }
  bezirk({required String name}) {}
}





