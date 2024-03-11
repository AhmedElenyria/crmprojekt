import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Filiale.dart';
import 'Bezirk.dart';
import 'KontaktEntry.dart';




class KontaktHistoryAddingPage extends StatefulWidget {
  @override
  _KontaktHistoryAddingPageState createState() => _KontaktHistoryAddingPageState();
}
class _KontaktHistoryAddingPageState extends State<KontaktHistoryAddingPage> {
   ActivityType? selectedActivityType;
   initiatorOptions? selectedinitiator;
  DateTime? selectedDate;
   String? selectedFiliale;
   String kundeName = '';
  String kundeVorname = ''; 
  List<String> filialen = []; 
  List<String> kunden = [];
  List<KontaktEntry> entries = [];
  String customerNeeds = '';
  String angebot ='';
     bool acceptance = false; 
  String rejectionReason = ''; 
  String bankContactPerson= ''; 
  
   // Populate this list with your Filiale objects

  @override
 void initState() {
  super.initState();
}
Future<bool> checkKontaktHistoryExists(String filialeId, String name, String vorname) async {
  final uri = Uri.parse('http://localhost:8080/api/kontaktentries/check-kunde-in-filiale');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'filialeId': filialeId,
      'name': name,
      'vorname': vorname,
    }),
  );

  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    return result['exists'];
  } else {
   
    print('Error checking Kunde: ${response.body}');
    return false;
  }
}


    Future<void> saveEntryToBackend(KontaktEntry entry) async {
  final uri = Uri.parse('http://localhost:8080/api/kontaktentries');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(entry.toJson());

  final response = await http.post(uri, headers: headers, body: body);

  if (response.statusCode == 201) {
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kontaktverlauf hinzügefugt ')));
    
  } else {
  
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save entry to backend')));
  }
}
void addKontaktHistory(String filialeId, String name, String vorname) async {
  try {
    bool kundeExists = await checkKontaktHistoryExists(filialeId, name, vorname);
    if (!kundeExists) {
    
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kunde in der Filiale nicht gefunden, Könnte nicht Kontaktverlauf hinzufügen')),
      );
    } else {
     
    }
  } catch (e) {
   
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to check Kunde existence')));
  }
}

  void saveEntry() {
  if ( selectedFiliale != null && selectedActivityType != null && selectedDate != null && kundeName.isNotEmpty && kundeVorname.isNotEmpty) {
    
    final entry = KontaktEntry(
      filialeName: selectedFiliale!,
      kundeName: kundeName,
      kundeVorname: kundeVorname,
      activityType: selectedActivityType!,
      date: selectedDate!,
      initiator: selectedinitiator!,
       customerNeeds: customerNeeds,
       angebot: angebot,
       acceptance: acceptance!,
         rejectionReason: rejectionReason,
          
    );


    setState(() {
      entries.add(entry);
    });


    saveEntryToBackend(entry);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bitte Alle felder ausfüülen')));
  }
}
 
 
      
  
  final List<Filiale> filiales = [
  Filiale(id: 10, name: 'Filiale Darmstadt', bezirk: Bezirk(id: 30, name: 'Bezirk Mitte', filialen: []), kunden: []),
  Filiale(id: 20, name: 'Filiale Frankfurt', bezirk: Bezirk(id: 30, name: 'Bezirk Mitte', filialen: []), kunden: []),
  Filiale(id: 30, name: 'Filiale Mainz', bezirk: Bezirk(id: 30, name: 'Bezirk Mitte', filialen: []), kunden: []),
  Filiale(id: 40, name: 'Filiale Wiesbaden', bezirk: Bezirk(id: 30, name: 'Bezirk Mitte', filialen: []), kunden: []),
];
 
void handleSubmit() async {

  if (selectedFiliale == null || selectedActivityType == null || selectedDate == null || kundeName.isEmpty || kundeVorname.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Füllen Sie alle felder aus.')));
    return;
  }

 
  Filiale? selected = filiales.firstWhere((filiale) => filiale.name == selectedFiliale);
  
  if (selected == null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bitte wählen Sie eine Filiale")));
    return;
  }


  String filialeId = selected.id.toString(); 

  try {
  bool exists = await checkKontaktHistoryExists(filialeId, kundeName, kundeVorname);
if (!exists) { 
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kunde nicht gefuden, Kontaktverlauf kann nicht hinzügefugt werden.')));
} else {
 
  final entry = KontaktEntry(
    filialeName: selectedFiliale!,
    kundeName: kundeName,
    kundeVorname: kundeVorname,
    activityType: selectedActivityType!,
    date: selectedDate!,
    customerNeeds: customerNeeds,
    angebot: angebot,
    acceptance: acceptance!,
    rejectionReason: rejectionReason,
    initiator: selectedinitiator!,
    
  );

  // Save the new entry to the backend.
  saveEntryToBackend(entry);
}
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to check Kontakt history')));
  }
}


  

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontakt History'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedFiliale,
              hint: Text('Bitte wählen Sie eine Filiale'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFiliale = newValue;
                });
              },
              items: filiales.map<DropdownMenuItem<String>>((Filiale filiale) {
                return DropdownMenuItem<String>(
                  value: filiale.name,
                  child: Text(filiale.name),
                );
              }).toList(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) => setState(() => kundeName = value),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Vorname'),
              onChanged: (value) => setState(() => kundeVorname = value),
            ),
            DropdownButton<ActivityType>(
              value: selectedActivityType,
              hint: Text('Bitte wählen Sie Kontaktart'),
              onChanged: (ActivityType? newValue) {
                setState(() {
                  selectedActivityType = newValue;
                });
              },
              items: ActivityType.values.map<DropdownMenuItem<ActivityType>>((ActivityType value) {
                return DropdownMenuItem<ActivityType>(
                  value: value,
                  child: Text(value.toString().split('.').last.replaceAll('_', ' ')),
                );
              }).toList(),
            ),
            ListTile(
              title: Text('Bitte wählen Sie ein Datum: ${selectedDate != null ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}" : "Noch kein Datum festgestellt"}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
              DropdownButton<initiatorOptions>(
              value: selectedinitiator,
              hint: Text('Bitte wählen Sie einen initiator'),
              onChanged: (initiatorOptions? newValue) {
                setState(() {
                  selectedinitiator = newValue;
                });
              },
              items: initiatorOptions.values.map<DropdownMenuItem<initiatorOptions>>((initiatorOptions value) {
                return DropdownMenuItem<initiatorOptions>(
                  value: value,
                  child: Text(value.toString().split('.').last.replaceAll('_', ' ')),
                );
              }).toList(),
            ),
             TextField(
            decoration: InputDecoration(labelText: 'Bitte geben sie das Kundenbedürfnis ein'),
            onChanged: (value) => setState(() => customerNeeds = value),
          ),
           TextField(
            decoration: InputDecoration(labelText: 'Bitte geben sie  einen Angebot ein '),
            onChanged: (value) => setState(() => angebot = value),
          ),
           SwitchListTile(
            title: Text('Annahme'),
            value: acceptance ?? false,
            onChanged: (bool value) {
              setState(() {
                acceptance = value;
              });
            },
          ),
             TextField(
      decoration: InputDecoration(labelText: 'Grund für die Ablehnung'),
      onChanged: (value) => setState(() => rejectionReason = value),
      enabled: !acceptance, 
    ),
        
            if (selectedFiliale != null && selectedActivityType != null && selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Filiale: $selectedFiliale\nKunde: $kundeVorname $kundeName\nActivity: ${selectedActivityType.toString().split('.').last.replaceAll('_', ' ')}\nDate: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
              ),
              ElevatedButton(
  onPressed: handleSubmit,
  child: Text('Eintrag speichern'),
),
SizedBox(height: 20),
ListView.builder(
  shrinkWrap: true, 
  physics: NeverScrollableScrollPhysics(), 
  itemCount: entries.length,
  itemBuilder: (context, index) {
    final entry = entries[index];   
 
  }       
        ),
          ]
      )
    )
    );
  }

}
