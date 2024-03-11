import 'package:flutter/material.dart';
import 'KontaktEntry.dart';
import 'package:intl/intl.dart'; // Ensure this import is correct

class KontaktDetailPage extends StatelessWidget {
  final KontaktEntry kontaktEntry;

  KontaktDetailPage({Key? key, required this.kontaktEntry}) : super(key: key);
    String ActivityTyp(ActivityType? activityTypeSTR) {
  
  if (activityTypeSTR == null) {
    return "Unbekannte";
  }
  switch (activityTypeSTR) {
    case ActivityType.EMAIL:
      return "EMAIL";
    case ActivityType.PHONE_CALL:
      return "EMAIL";
    case ActivityType.IN_PERSON_MEETING:
      return "IN_PERSON_MEETING";
       case ActivityType.VIDEO_CALL:
      return "VIDEO_CALL";
       case ActivityType.Social_Media_Interactions:
      return "Social_Media_Interactions";
       case ActivityType.others:
      return "others";
    default:
      return "Unbekanntee";
  }
}
  String initiator(initiatorOptions? initiatorTypeStr){
      if (initiatorTypeStr == null) {
    return "Unbekannte";
  }
   switch (initiatorTypeStr) {
    case initiatorOptions.Kunde:
      return "Kunde";
    case initiatorOptions.Bank:
      return "Bank";
  }
  }
 
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Kontaktverlauf'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Filiale: ${kontaktEntry.filialeName}', style: TextStyle(fontSize: 18)),
                    subtitle: Text("Name: ${kontaktEntry.kundeName}\nVorname: ${kontaktEntry.kundeVorname}", style: TextStyle(fontSize: 18)),
                  ),
                  Divider(),
                  Text("Kontaktart: ${ActivityTyp(kontaktEntry.activityType)}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Datum: ${kontaktEntry.date != null ? DateFormat('dd.MM.yyyy').format(kontaktEntry.date) : 'Unbekannt'}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Initiator: ${initiator(kontaktEntry.initiator)}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Kundenbedürfnis: ${kontaktEntry.customerNeeds}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Angebot: ${kontaktEntry.angebot}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Annahme: ${kontaktEntry.acceptance ? 'Ja' : 'Nein'}", style: TextStyle(fontSize: 18, color: kontaktEntry.acceptance ? Colors.green : Colors.red)),
                  SizedBox(height: 8),
                  if (!kontaktEntry.acceptance) 
                    Text('Grund für die Ablehnung: ${kontaktEntry.rejectionReason.isNotEmpty ? kontaktEntry.rejectionReason : "N/A"}', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}