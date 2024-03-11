import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import  'StaticCredentials.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;

  Future<void> authenticateUser() async {
    final String apiUrl = 'http://localhost:8080/api/login'; //wird den API für Login aufgerufen 

    final Map<String, String> credentials = {
      'username': username.text,
      'password': password.text,
    };

 try {
      final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(credentials),);
        print(response.body);

      if(response.statusCode==200){
      //if (response.body=="kundebetreuer" || response.body=="initialPasswort") {
       String responseBody=response.body;
       //print(response.body);jetzt können wir den Inhalt von responseBody überprüfen und dann lassen Sie uns ihn ausgeben

            if (responseBody.contains("initialPasswort"))//if responseBody ist initialPasswort dann Navigate to the neuespasswort Page
             {
              Navigator.pushNamed(context,'/neuespasswort',arguments: {'loggedInUsername': username.text},); 
            
            }else if (responseBody.contains("Passwortablauf")){
            Navigator.pushNamed(context,'/Passwortablauf',arguments: {'loggedInUsername': username.text},); 
            }
             else if (responseBody.contains('Ihr Passwort bleibt für die nächsten 10 Tage gültig') ||responseBody.contains('Ihr Passwort bleibt für die nächsten 5 Tage gültig') || responseBody.contains('Ihr Passwort bleibt für die nächsten 2 Tage gültig')  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Passwortbenachrichtigung'),
          content: Text(responseBody),
          actions: <Widget>[
            TextButton(  // Ändern Sie FlatButton zu TextButton
              child: Text('OK'),
              onPressed: () {
                // Hier Navigation zur kundenbetreuerpage durchführen
                //Navigator.pushReplacementNamed(context, '/kundenbetreuerpage');
                Navigator.pushNamed(context,'/Kundebetreuer',arguments: {'loggedInUsername': username.text},);
              },
          ),
        ],
      );
    },
  );
}
else {
              //sonst navigate zu der Seite von dem Kundenbetreuern
              Navigator.pushNamed(context,'/Kundebetreuer',arguments: {'loggedInUsername': username.text},);}
              }

//Hier werden die statische Daten überprüfen ob der Benutzer als admin1 oder admin2 angemeldet ist

      else if (username.text == StaticCredentials.username1 && password.text == StaticCredentials.password1 ) {
                Navigator.pushReplacementNamed(context,'/DashboardPage1',arguments: {'loggedInUsername': username.text},); //DashboardPage ist nur für admin1
              
      }else if (username.text == StaticCredentials.username2 && password.text == StaticCredentials.password2 ) {                
                Navigator.pushReplacementNamed(context,'/DashboardPage2',arguments: {'loggedInUsername': username.text},);//DashboardPage ist nur für admin2
      }else {
         //sonst kriegen wir Fehler bei falsche Angaben/Daten(ungültig Benutzername oder Passwort)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(  content: Text('Falsches Passwort oder Benutzername',),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }catch (e) {
      // Hier wird Fehler behandelt und in konsol von Flutter ausgegeben
      print('Fehler während der Anmeldung: $e');}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login-Seite'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 65.0,
                backgroundImage: AssetImage('assets/CRM.jpg'), // Pfad zu deinem Logo
              ),
           
            TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: 'Benutzername',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                 fillColor: Color.fromARGB(255, 249, 250, 250),
              ),
            ),
            TextField(
            controller: password,
            obscureText:!showPassword,
            decoration: InputDecoration(
              labelText: 'Passwort',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 245, 245, 246),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: showPassword,
                  onChanged: (value) {
                    setState(() {
                      showPassword = value!;
                    });
                  },
                ),
                Text('Passwort anzeigen'),
              ],
            ),
            ElevatedButton(
              onPressed: authenticateUser,//Die Funktion authenticaterUser() Überprüft die Gültigkeit der Daten
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Anmelden'),
            ),
          ],
        ),
      ),
    );
  }
}