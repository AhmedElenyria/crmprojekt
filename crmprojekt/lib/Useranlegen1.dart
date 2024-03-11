import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Useranlegen1 extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<Useranlegen1> {
  
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController adminC = TextEditingController(text: "admin1");
  TextEditingController statusC = TextEditingController(text: "Aktivierung ausstehend");
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordStatusC = TextEditingController(text : "initialPasswort");

  
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool isPasswordEditable = true; 

void initState() {
    super.initState();

    // Generate a random password when the widget initializes
    String initialPassword = generatePassword(8);
    
    // Initialize the controller with the generated password
    passwordC = TextEditingController(text: initialPassword);
    isPasswordEditable = false;
  }



  
String generatePassword(int length) {
  const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
  ));
}

Future<bool> sendDataToSpringBoot() async {
  print('vor dem API Call');

  try {
    const apiUrl = 'http://localhost:8080/api/createUser'; 

    final Map<String, dynamic> data = {
      'name': nameC.text,
      'email': emailC.text,
      'admin': adminC.text,
      'username': usernameC.text,
      'password': passwordC.text,
      'status': statusC.text,
      'passwortStatus':passwordStatusC.text
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    print('Nach dem API Aufruf');
    print('Spring Boot Antwort:');
    print(response.body);

    if (response.statusCode == 200) {
      print('Daten erfolgreich an Spring Boot gesendet');
      return true;
    } else if (response.statusCode == 400) {
      //Nutzer existiert bereits oder ein anderer Validierungsfehler ist aufgetreten
      print('Kundenbetreuer mit dieser Benutzername oder dieser E-Mail-Adresse existiert bereits');
      return false;
    } else {
      print('Fehler beim Senden von Daten an Spring Boot. Statuscode:  ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Fehler beim API Aufruf: $e');
    return false;
  }
}



RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

String? validateField(String? value, String fieldName) {
  if (_autovalidateMode == AutovalidateMode.always && (value == null || value.isEmpty)) {
    return '$fieldName ist erforderlich ';
  }

  // Additional validation for the email field
  if (fieldName == 'Email' && !emailRegex.hasMatch(value!)) {
    return 'Ungültiges E-Mail-Format';
  }

  return null;
}


void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Erfolg'),
        content: Text('Kundenbetreuer erfolgreich erstellt'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Useranlegen1()));
               Navigator.pushReplacementNamed(context, '/Useranlegen1');
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


void _submitForm() async {
  setState(() {
    _autovalidateMode = AutovalidateMode.always; // Set _autovalidateMode to always to trigger validation
  });

  if (_formKey.currentState!.validate()) {
    bool userCreated = await sendDataToSpringBoot();

    if (userCreated) {
      // User created successfully
      nameC.clear();
      emailC.clear();
      usernameC.clear();
      passwordC.clear();
      setState(() {
        _autovalidateMode = AutovalidateMode.disabled;
        showSuccessDialog(context); // Reset _autovalidateMode
      });
    } else {
      // User creation failed (e.g., user already exists)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ein Kundenbetreuer mit diesem Benutzernamen oder dieser E-Mail-Adresse existiert bereits'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text ('Bitte füllen Sie alle erforderlichen Felder aus'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kundenbetreuer anlegen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              TextFormField(
                controller: nameC,
                decoration: InputDecoration(
                  labelText: 'Name*',
                  hintText: 'Geben Sie einen Namen ein',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => validateField(value, 'Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: 'Email*',
                  hintText: 'Geben Sie die Email ein',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => validateField(value, 'Email'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: usernameC,
                decoration: InputDecoration(
                  labelText: 'Benutzername*',
                  hintText: 'Benutzername wählen',
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => validateField(value, 'Benutzername'),
              ),
              SizedBox(height: 16.0),
              
              TextFormField(
                controller: passwordC,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  hintText: 'Geben Sie das Passwort ein',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                obscureText: true,
                enabled: isPasswordEditable,
                validator: (value) => validateField(value, 'Passwort'),
              ),

          
              SizedBox(height: 16.0),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        
                        onPressed: _submitForm,

                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("Kundenbetreuer anlegen"),
                      ),
                      
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.disabled; // Reset _autovalidateMode
                            nameC.clear();
                            emailC.clear();
                            usernameC.clear();
                            //passwordC.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("Textfelder löschen"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

