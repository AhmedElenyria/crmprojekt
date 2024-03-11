import 'dart:convert';

import 'package:crmprojekt/EmailSend.dart';
import 'package:flutter/material.dart';
import 'EmailSend.dart';
import 'EmailVersandListe.dart';
import 'EmailSendingPage.dart';
import 'package:intl/intl.dart'; 
import 'package:http/http.dart' as http;



class EmailVersandListPage extends StatefulWidget {
  @override
  _EmailVersandListPageState createState() => _EmailVersandListPageState();
}

class _EmailVersandListPageState extends State<EmailVersandListPage> {
   List<EmailSend> emails = [];
 late Future<List<EmailSend>> futureEmails;
  

  @override
  void initState() {
    super.initState();
    futureEmails = fetchEmails();
  }
 Future<List<EmailSend>> fetchEmails() async {
    final uri = Uri.parse('http://localhost:8080/api/emailversand');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> emailJsonList = json.decode(response.body);
      return emailJsonList.map((json) => EmailSend.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load emails');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Gespeicherte Emails'),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true, 
    ),
    body: FutureBuilder<List<EmailSend>>(
      future: futureEmails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Fehler: ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => Divider(), 
            itemBuilder: (context, index) {
              EmailSend email = snapshot.data![index];
              return Card( 
                elevation: 1,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.email), 
                  title: Text('${email.kundeName} ${email.kundeVorname}', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Email: ${email.email}'),
                  trailing: Icon(Icons.arrow_forward_ios), 
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EmailVersandListe(emailSend: email),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: Text('Keine Daten verfügbar.'));
      },
    ),
    floatingActionButton: FloatingActionButton(
  onPressed: () => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => EmailSendingPage()),
  ),
  child: Icon(Icons.add),
  backgroundColor: Theme.of(context).colorScheme.secondary, 
  tooltip: 'Email Schicken',
),
  );
}
}