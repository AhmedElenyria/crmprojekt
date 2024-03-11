import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class passwortandern extends StatefulWidget {
  @override
  _PasswordConfirmationPageState createState() => _PasswordConfirmationPageState();
}

class _PasswordConfirmationPageState extends State<passwortandern> {
 // String loggedInUsername = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;

  @override
  void dispose() {
    usernameController.dispose();
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     //final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    //loggedInUsername = args?['loggedInUsername'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Password ändern'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Benutzername',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: oldPasswordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Altes Passwort',
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
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Geben Sie ein neues Passwort ein',
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
                labelText: 'Bestätigen Sie das Passwort',
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
                    Navigator.pushReplacementNamed(context, '/Kundebetreuer');
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
    if (usernameController.text.isNotEmpty &&
        oldPasswordController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (isValidPassword(passwordController.text)) {
        if (passwordController.text == confirmPasswordController.text) {




      final String backendUrl = 'http://localhost:8080/api/updatePassword1';

      final Map<String, String> credentials = {
        'username': usernameController.text,
        'oldPassword': oldPasswordController.text,
        'newPassword': passwordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(backendUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(credentials),
        );

        if (response.body=="Passwort wurde erfolgreich geändert") {
          //Passwort erfolgreich aktualisiert
           _showsuccessdialog(context,'',response.body,);
           usernameController.clear();
           oldPasswordController.clear();
           passwordController.clear();
           confirmPasswordController.clear();
          //Navigator.pushReplacementNamed(context, '/Kundebetreuer');
        } else {
          //print(response.body);  Handle error response from the backend
          _showErrorDialog2(context,'Fehler beim Aktualisieren des Passworts. Bitte versuchen Sie es erneut:',response.body,);
        }
      
      }catch (error) {
        //print('Fehler: $error');
        _showErrorDialog(context,'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut',);
      }
    
    } else {
          // Passwörter stimmen nicht überein
          _showErrorDialog(context,'Die Passwörter stimmen nicht überein. Bitte versuchen Sie es erneut.',
          );
        }
      
      } else {
        _showErrorDialog(context,'Ihr neues Passwort muss mindestens 8 Zeichen lang sein und folgende Kriterien erfüllen:\n- Mindestens ein Großbuchstabe\n- Mindestens ein Sonderzeichen',
        
        );
      }
    } else {
      //Leere Passwörter
      _showErrorDialog(context,'Felder dürfen nicht leer sein.',
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
void  _showsuccessdialog(BuildContext context, String errorMessage, String responseBody) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Erfolg!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage),
            SizedBox(height: 10),
            Text('$responseBody'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}




void _showErrorDialog2(BuildContext context, String errorMessage, String responseBody) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Fehler!'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage),
            SizedBox(height: 10),
            Text('$responseBody'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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
