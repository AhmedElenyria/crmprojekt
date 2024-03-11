import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Kunde.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeburtsdatumPage extends StatefulWidget {
  @override
  _GeburtsdatumPageState createState() => _GeburtsdatumPageState();
}

class _GeburtsdatumPageState extends State<GeburtsdatumPage> {
  List<Kunde> customersWithUpcomingBirthdays = [];
  



  @override
  void initState() {
    
    super.initState();
    fetchCustomersWithUpcomingBirthdays();
  }
 


  Future<void> fetchCustomersWithUpcomingBirthdays() async {
    final response = await http.get(Uri.parse('http://localhost:8080/kunde/db'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        customersWithUpcomingBirthdays = data.map((json) => Kunde.fromJson(json)).toList();
      });
    } else {
      // Handle error
      print('Failed to load customer data');
    }
  }

Future<void> sendEmail(String name, String email,int? kundeId) async {
  try {
    final serviceId = 'service_vnqbr73';
    final templateId = 'template_bf9wdlz';
    final userId = 'tWQJ4-PZHWP7YwCy6';
    final url = 'https://api.emailjs.com/api/v1.0/email/send';

    final Map<String, dynamic> data = {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'nachname': name,
        'Email': email,
      },
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {

      await updateEmailSentStatus(kundeId);
      Fluttertoast.showToast(
        msg: "Email erfolgreich versendet an $name!",
       
      );
    } else {
      Fluttertoast.showToast(
        msg: "Fehler beim Versenden der E-Mail. Statuscode: ${response.statusCode}",
      
      );
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Fehler bei der API-Aufruf: $e");
  }
}
Future<void> updateEmailSentStatus(int? kundeId) async {
  final url = Uri.parse('http://localhost:8080/kunde/$kundeId/emailSentForBirthday');
  final response = await http.put(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'sentStatus': true}));
  if (response.statusCode == 200) {
    Fluttertoast.showToast(msg: "Email status updated successfully.");
   
  } else {
    // Handle failure
    Fluttertoast.showToast(msg: "Failed to update email status.");
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Geburtsdatum'),
      backgroundColor: Theme.of(context).primaryColor,
    ),
    body: ListView.separated(
      itemCount: customersWithUpcomingBirthdays.length,
      itemBuilder: (context, index) {
        var customer = customersWithUpcomingBirthdays[index];
        // Assuming 'emailSentForBirthday' is a boolean property of 'Kunde' indicating if an email has been sent.
        bool isEmailSent = customer.emailSentForBirthday ?? false;

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: Icon(Icons.cake),
            title: Text(
              customer.Name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(customer.Gebursdatum)}',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: ElevatedButton(
              onPressed: isEmailSent ? null : () => sendEmail(customer.Name, customer.Email, customer.id),
              child: Text('Send'),
              style: ElevatedButton.styleFrom(
                primary: isEmailSent ? Colors.grey : Colors.green,
                onPrimary: Colors.white,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 1),
    ),
  );
}

}