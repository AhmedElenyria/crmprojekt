/*
import 'package:flutter/material.dart';
import 'Filiale.dart';
import 'KundenHinzufuegenPage.dart';
import 'Kunde.dart';
import 'KundenService.dart';
import 'Bezirk.dart';
// Import additional necessary classes

class KundenListePage extends StatefulWidget {
  final Filiale filiale;
   final Bezirk bezirk;

  KundenListePage({required this.filiale,required this.bezirk});

  @override
  _KundenListePageState createState() => _KundenListePageState();
}

class _KundenListePageState extends State<KundenListePage> {
  final KundenService kundenService = KundenService(); // Ensure this is correctly implemented
  List<Kunde> kunden = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndSetKundenList();
  }

  Future<void> fetchAndSetKundenList() async {
    try {
      List<Kunde> fetchedKunden = await kundenService.fetchKunden(widget.filiale.id,widget.bezirk.id);
      setState(() {
        kunden = fetchedKunden;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching and setting KundenList: $e');
      // Consider displaying an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kundenliste für ${widget.filiale.name}'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: kunden.length,
              itemBuilder: (context, index) {
                return _buildKundeListItem(kunden[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndRefresh,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

 Widget _buildKundeListItem(Kunde kunde) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: ListTile(
      title: Text('${kunde.Vorname} ${kunde.Name}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Email: ${kunde.Email}'),
          Text('Geburtsdatum: ${kunde.Gebursdatum.toString()}'),
          Text('Staatsangehörigkeit: ${kunde.Staatsangehorigkeit}'),
          Text('Wohnart: ${kunde.wohnart}'),
          Text('Familienstatus: ${kunde.familienstatus}'),
          Text('Berufsgruppe: ${kunde.berufsgruppe}'),
          Text('Branche: ${kunde.branche}'),
          Text('Selbstständig: ${kunde.selbststandig}, seit ${kunde.selbstandingseit.toString()}'),
          Text('Netto: ${kunde.netto}'),
          Text('Anzahl der Kinder: ${kunde.AnzahlderKinde}'),
          Text('Kundennummer: ${kunde.kundennummer}'),
          Text('Kontonummer: ${kunde.kontonummer}'),
          Text('Einverstanden Werbung per Email: ${kunde.einverstandenWerbungPerEmail ? 'Ja' : 'Nein'}'),
          Text('Einverstanden Übermittlung an Schufa: ${kunde.einverstandenUebermittlungAnSchufa ? 'Ja' : 'Nein'}'),
          // Add more fields as necessary
        ],
      ),
      isThreeLine: true,
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Implement navigation to detailed customer view if necessary
      },
    ),
  );
}


  void _navigateAndRefresh() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KundenHinzufuegenPage(filiale: widget.filiale,bezirk: widget.bezirk),
      ),
    );
    fetchAndSetKundenList();
  }
}*/

import 'package:flutter/material.dart';
import 'Filiale.dart';
import 'KundenHinzufuegenPage.dart';
import 'Kunde.dart';
import 'KundenService.dart';
import 'Bezirk.dart';
import 'KundeEdit.dart';
import 'KundeDetailView.dart';

class KundenListePage extends StatefulWidget {
  final Filiale filiale;
  final Bezirk bezirk;

  KundenListePage({required this.filiale,required this.bezirk});

  @override
  _KundenListePageState createState() => _KundenListePageState();
}

class _KundenListePageState extends State<KundenListePage> {
  final KundenService kundenService = KundenService();
  List<Kunde> kunden = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndSetKundenList();
  }

  Future<void> fetchAndSetKundenList() async {
    try {
   
      List<Kunde> fetchedKunden = await kundenService.fetchKunden(widget.filiale.id,widget.bezirk.id);
      print('Fetched Kunden: $fetchedKunden'); 
      setState(() {
        kunden = fetchedKunden;
        isLoading = false;
        if (fetchedKunden.isEmpty) {
  print("Fetched Kunden list is empty");
}
      });
      

    }catch (e, stacktrace) {
  print('Error fetching and setting KundenList: $e');
  print('Stack trace: $stacktrace');
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kundenliste für ${widget.filiale.name}'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: kunden.length,
              itemBuilder: (context, index) {
                Kunde kunde = kunden[index];
              return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('${kunde.Vorname} ${kunde.Name}'),
          subtitle: Text(
                            '${kunde.PLZ}, ${kunde.Strasse}, ${kunde.Ort}'),
                            trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KundeEditPage(kunde: kunde),
                          ),
                      );
                    },
                  ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KundeDetailView(kunde: kunde),
            )
          );
        }
      ),
    );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndRefresh,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /*Widget _buildKundeListItem(Kunde kunde) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('${kunde.Vorname} ${kunde.Name}'),
          subtitle: Text(
                            '${kunde.PLZ}, ${kunde.Strasse}, ${kunde.Ort}'),
        onTap: () {
        },
      ),
    );
  }*/

  void _navigateAndRefresh() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KundenHinzufuegenPage(filiale: widget.filiale,bezirk: widget.bezirk),
      ),
    );
    await fetchAndSetKundenList();
  }
}
