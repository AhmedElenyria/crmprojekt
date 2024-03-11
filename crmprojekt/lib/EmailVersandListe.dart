import 'package:crmprojekt/EmailSend.dart';
import 'package:flutter/material.dart';
import 'KontaktEntry.dart';
import 'package:intl/intl.dart'; 

class EmailVersandListe extends StatelessWidget{
  final EmailSend emailSend ;

   EmailVersandListe({Key? key, required this.emailSend}) : super(key: key);
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Versand'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4, 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.email, color: Theme.of(context).primaryColor),
                  title: Text("${emailSend.kundeName} ${emailSend.kundeVorname}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: Text("${emailSend.email}"),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Betreff: ${emailSend.betreff}', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Inhalt: ${emailSend.inhalt}", style: TextStyle(fontSize: 18)),
                ),
                
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
