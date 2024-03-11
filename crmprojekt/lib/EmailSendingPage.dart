
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';


class EmailSendingPage extends StatefulWidget {
  @override
  _EmailSendingPageState createState() => _EmailSendingPageState();
}

class _EmailSendingPageState extends State<EmailSendingPage> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _betreffController = TextEditingController();
  final TextEditingController _inhaltController = TextEditingController();

    @override
 void initState() {
  super.initState();
}
 Future<bool> checkKundeExists(String name, String vorname, String email) async {
  
  final uri = Uri.parse('http://localhost:8080/api/emailversand/check-kunde');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'kundeName': name,
        'kundeVorname': vorname,
        'email':email,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['exists'];
    } else {
      print('Failed to check Kunde: ${response.body}');
      return false;
    } 
 }
 Future<void> sendEmailok() async {
  if (_betreffController.text.isEmpty || _inhaltController.text.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bitte fühlen Sie alle Felder aus")),
    );
    return; 
  }
     bool kundeExists = await checkKundeExists(_nameController.text, _vornameController.text, _emailController.text);
  if (!kundeExists) {
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Kunde nicht gefunden.'),
    duration: Duration(seconds: 2),
  ),
);
   
    return;
  }
    try {
      final serviceId = 'service_h731q5j';
      final templateId = 'template_ctshi4o';
      final userId = 'oDcx44XpoKYGmoQ-4';
      final url = 'https://api.emailjs.com/api/v1.0/email/send';

      final Map<String, dynamic> data = {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,

        'template_params': {
          'Name': _nameController.text,
          'Vorname':_vornameController.text,
          'Email': _emailController.text,
          'Betreff': _betreffController.text,
          'Inhalt': _inhaltController.text,
        },
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'origin': 'http://localhost','Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

 

      if (response.statusCode == 200) {
      print('E-Mail erfolgreich versendet!');
       Fluttertoast.showToast(msg: "E-Mail erfolgreich versendet!");
      clearFields();
      } else {print('Kunde nich gefunden. Statuscode: ${response.statusCode}');}
} catch (e){print('Fehler bei der API-Aufruf: $e');}
  
 

}

  void clearFields() {
    _nameController.clear();
    _vornameController.clear();
    _emailController.clear();
    _betreffController.clear();
    _inhaltController.clear();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Versand'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _vornameController, decoration: InputDecoration(labelText: 'Vorname')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _betreffController, decoration: InputDecoration(labelText: 'Betreff')),
            TextField(controller: _inhaltController, decoration: InputDecoration(labelText: 'Inhalt'), maxLines: 3),
            SizedBox(height: 20),
            ElevatedButton(onPressed: sendEmailok, child: Text('Senden')),
           ElevatedButton(
  onPressed: clearFields,
  child: Text('Eingabefelder leeren'),
  style: ElevatedButton.styleFrom(
    primary: Colors.red, // Button color
    onPrimary: Colors.white, // Text color
  ),
),
          ],
        ),
      ),
    );
  }
}






