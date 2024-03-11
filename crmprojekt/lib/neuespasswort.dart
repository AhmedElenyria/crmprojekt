import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class neuespasswort extends StatefulWidget {
   @override
  _PasswordConfirmationPageState createState() =>
      _PasswordConfirmationPageState();}

class _PasswordConfirmationPageState extends State<neuespasswort> {
  String loggedInUsername='';
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final Map<String, dynamic>? args =ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  final hinweis="Kennwortanforderungen:\n\nMindestens 8 Zeichen\nMindestens ein Großbuchstabe\nMindestens ein Sonderzeichen";
  loggedInUsername = args?['loggedInUsername'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwortbestätigung'),
      ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hinweis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20.0, 
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Geben sie neues Passwort ein ',
                suffixIcon: IconButton(
                    icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: confirmPasswordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Bestätigen sie das Passwort',
                suffixIcon: IconButton(
                    icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                    onPressed: () {
                      setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _onConfirmButtonPressed(context),
                  child: Text('Bestätigen'),
                ),
                ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Abbrechen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _onConfirmButtonPressed(BuildContext context) async {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) 
        {
      if (isValidPassword(passwordController.text)) {
        if (passwordController.text == confirmPasswordController.text) {
          // Passwörter sind identisch 
          //print(' passwort wird geändert: ${passwordController.text}');
          //print(loggedInUsername);

          final String backendUrl = 'http://localhost:8080/api/updatePassword';

          final Map<String, String> credentials = {
      'username': loggedInUsername,
      'password': passwordController.text,
    };

    try {
      final response = await http.post(Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(credentials),
      );

          if (response.statusCode == 200) {
            //Passwort erfolgreich aktualisiert dann navigate zu der  Kundebetreuer-Seite 
            Navigator.pushReplacementNamed(context, '/Kundebetreuer');
          
          } else {
            // Fehler behandeln von Backend
            _showErrorDialog(
              context,'Fehler beim Aktualisieren des Passworts. Bitte versuchen Sie es erneut',
            );
          }
        
        } catch (error) {
          print('Fehler: $error');
          _showErrorDialog(context,'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut',
          );
        }
        
        } else {
          // Passwörter stimmen nicht überein
          _showErrorDialog(context,'Die Passwörter stimmen nicht überein. Bitte versuchen Sie es erneut.',
          );
        }
      
      } else {
        //Ungültige Passwortkriterien
        _showErrorDialog(context,'Ihr neues Passwort muss mindestens 8 Zeichen lang sein und folgende Kriterien erfüllen:\n- Mindestens ein Großbuchstabe\n- Mindestens ein Sonderzeichen',
        );
      }
    } else {
      //Leere Passwörter
      _showErrorDialog(context,'Passwörter dürfen nicht leer sein.',
      );
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fehler'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () { Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  bool isValidPassword(String password) {
  // Überprüfen Sie, ob das Passwort mindestens 8 Zeichen lang ist
  if (password.length < 8) {
    return false;
  }

  // Überprüfen Sie, ob das Passwort mindestens einen Großbuchstaben enthält.
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Überprüfen Sie, ob das Passwort mindestens ein Sonderzeichen enthält
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }
  return true;
}
}