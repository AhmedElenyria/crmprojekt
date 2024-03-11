import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<List<Map<String, dynamic>>> fetchData() async {
const apiUrl = "http://localhost:8080/api/getallusers";
 
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    print("Successfully");
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}


class Listofbenutzer2 extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}



class _DataTableExampleState extends State<Listofbenutzer2> {
  List<Map<String, dynamic>> _data = [];
  List<bool> rowButtonEnabledList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        _data = data.where((rowData) => rowData['status'] == 'aktiv' || rowData['status'] == 'Aktivierung ausstehend' || rowData['status'] == 'Loeschung ausstehend').toList();
       
        // Initialize rowButtonEnabledList with 'true' for each row
        rowButtonEnabledList = List.generate(_data.length, (index) => true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste der Kundenbetreuer',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Adjust the color as needed
          ),
        ),
      ),

      /*
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [ */
          
      body: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Set the horizontal scroll direction
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Benutzername',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            /*DataColumn(
              label: Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            */
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Option 1',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Option 2',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Option 3',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Option 4',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Erstellungsdatum',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Ablaufdatum',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
          rows: _data.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> rowData = entry.value;

            return DataRow(
              cells: [
                DataCell(Text(rowData['name'])),
                DataCell(Text(rowData['email'])),
                DataCell(Text(rowData['username'])),
                //DataCell(Text('*' * rowData['password'].toString().length)),
                DataCell(Text(rowData['status'])),
                DataCell(
                  ElevatedButton(
                    onPressed: rowButtonEnabledList[index] &&
                        (rowData['admin'] == "admin1" && rowData['status'] == "Aktivierung ausstehend")
                        ? () { _handleFreigeben(rowData['id'], index,rowData['name'],rowData['username'],rowData['email'],rowData['password']);
                        showSuccessDialogFreigabe(context,rowData['username']);
                        }
                        : null,
                    child: Text('Freigeben'),
                  ),
                ),
                DataCell(
                  ElevatedButton(
                    onPressed: rowButtonEnabledList[index] &&
                        (rowData['admin'] == "admin1" && rowData['status'] == "Aktivierung ausstehend")
                        ? () => _showRejectedDialog(rowData['id'], index,rowData['name'],rowData['username'],rowData['email'],rowData['password'])
                        : null,
                        
                    child: Text('Ablehnen'),
                  ),
                ),



                 DataCell(
  ElevatedButton(
    onPressed: rowButtonEnabledList[index] &&
        ((rowData['status'] == "aktiv") ||
        (rowData['admin'] == "admin1" && rowData['status'] == "Loeschung ausstehend" ))
        ? () {
            if (rowData['status'] == "aktiv") {
              // Call function1
              function1(rowData['id'], index, rowData['name'], rowData['username'], rowData['email'], rowData['password']);
            } else {
              // Call function2
              function2(rowData['id'], index, rowData['name'], rowData['username'], rowData['email'], rowData['password']);
              showSuccessDialogloschen(context,rowData['username']);
            }
          }
        : null,
    child: Text('Löschen'),
  ),
),
                
                DataCell(
                  ElevatedButton(
    onPressed: () => _passwortzurucksetzen(rowData['id'], index, rowData['name'], rowData['username'], rowData['email'], rowData['password']),
    child: Text('Passwort zurücksetzen'),
  ),
),

              DataCell(
             Text(
    rowData['edatum'] != null
        ? DateFormat('dd.MM.yyyy').format(DateTime.parse(rowData['edatum']).toLocal())
        : 'Warten auf Aktivierung',
    style: TextStyle(fontSize: 14), // Adjust the font size as needed
  ),
),

DataCell(
  Text(
    rowData['adatum'] != null
        ? DateFormat('dd.MM.yyyy').format(DateTime.parse(rowData['adatum']).toLocal())
        : 'Warten auf Aktivierung',
    style: TextStyle(fontSize: 14), // Adjust the font size as needed
  ),
),

              ],
            );
          }).toList(),
       ),
      ),
    ),
  );
}




void _handleFreigeben(int userId, int rowIndex,String name,String username,String email,String password) async {
  // Save the initial status before updating
  String initialStatus = _data[rowIndex]['status'];

  // Update the state optimistically
  setState(() {
    rowButtonEnabledList[rowIndex] = false;
    // Assuming '_data' is a list and 'status' is one of its properties
    _data[rowIndex]['status'] = 'aktiv';

    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    _data[rowIndex]['edatum'] = formattedDate;// Current date and time


    DateTime nextDate = DateTime.now().add(Duration(days : 3 * 30));
   String nextDate2 = DateFormat('yyyy-MM-dd').format(nextDate);
    _data[rowIndex]['adatum'] = nextDate2;
    print(name);
    print(username);
    print(email);
    print(password);
  });


try{
    final serviceId = 'service_h731q5j';
    final templateId = 'template_4zpy4lr';
    final userId = 'oDcx44XpoKYGmoQ-4';



    final url = 'https://api.emailjs.com/api/v1.0/email/send';

    final Map<String, dynamic> data = {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      
      'template_params': {
        'name': name,
        'email': email,
        //'subject': subjectC.text,
        'username': username,
        'password':password,
      },
    };
  

  final response = await http.post(
  Uri.parse(url),
  headers: {
    'origin': 'http://localhost',
    'Content-Type': 'application/json',
  },
  body: jsonEncode(data), 
);


  print('after API Call');

  print('EmailJS Response:');
  print(response.body);

    if (response.statusCode == 200) {
     
      print('Email sent successfully!');
    } else {
      // Handle error
      print('Failed to send email. Status code: ${response.statusCode}');
    }
  
  } catch (e) {

    print('Error during API call: $e');
  }





  try {
    final apiUrl = "http://localhost:8080/api/$userId/updateStatus";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'newStatus': 'aktiv',
      },
    );

    if (response.statusCode == 200) {
      print("User status updated successfully");
      // Update the UI based on the actual result
      setState(() {
        // Assuming '_data' is a list and 'status' is one of its properties
        _data[rowIndex]['status'] = 'aktiv';
        //_data[rowIndex]['edatum']=
        //_data[rowIndex]['adatum']=
       
      DateTime currentDate = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
  

      _data[rowIndex]['edatum'] = formattedDate; // Current date and time

      DateTime nextDate = DateTime.now().add(Duration(days: 3 * 30));
      String formattedDate2 = DateFormat('yyyy-MM-dd').format(nextDate);
  
      _data[rowIndex]['adatum'] =formattedDate2;
    
      });
    } else {
      print("Failed to update user status  :");
      print(response.statusCode);
      // Revert the button state if the update fails
      setState(() {
        rowButtonEnabledList[rowIndex] = true;
        // Revert the UI change
        // Assuming 'initialStatus' is the status before the update
        _data[rowIndex]['status'] = initialStatus;
      });
    }
  } catch (e) {
    print("Error: $e");
    rowButtonEnabledList[rowIndex] = true;
        _data[rowIndex]['status'] = initialStatus;
    
}
/*
Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Listofbenutzer2()), // Replace YourPage with the actual name of your page class
    );*/

}


void _showRejectedDialog(int userId, int rowIndex, String name, String username, String email, String password) {
  TextEditingController rejectReasonController = TextEditingController();
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Ablehnungsbegründung'),
      content: Column(
        children: [
          Text('Bitte geben Sie den Grund für die Ablehnung ein:'),
          SizedBox(height: 10),
          TextFormField(
            controller: rejectReasonController,
            maxLength: 100,
            decoration: InputDecoration(
              hintText: 'Grund eingeben (max. 100 Zeichen)...',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Dieses Feld ist erforderlich.';
              } else if (value.length > 100) {
                return 'Der Grund darf nicht mehr als 100 Zeichen haben.';
              }
              return null; // Return null if the input is valid
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Schließt den Dialog
          },
          child: Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            String rejectReason = rejectReasonController.text.trim();
            if (rejectReason.isNotEmpty) {
              _showRejectedDialog2(userId, rowIndex, rejectReason, name, username, email, password);
              Navigator.of(context).pop(); // Schließt den Dialog nach der Bestätigung
            } else {
              // Show an error message or handle the empty case accordingly
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bitte geben Sie einen Grund ein.'),
                ),
              );
            }
          },
          child: Text('Ablehnen'),
        ),
      ],
    );
  },
);



}


_showRejectedDialog2(int userId, int rowIndex, String rejectReason ,String name, String username, String email, String password)
             async {
              setState(() {});

try {
    final apiUrl = "http://localhost:8080/api/$userId/reject";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'newStatus': rejectReason,
      },
    );

    if (response.statusCode == 200) {
      print("Kundebetreuer erfolgreich aktualisiert");

    } else {
      print("Aktualisierung des Nutzerstatus fehlgeschlagen");
      // Revert the button state if the update fails
     setState(() {
      });
    }
  } catch (e) {
    print("Error: $e");
    //rowButtonEnabledList[rowIndex] = true;
      //  _data[rowIndex]['status'] = initialStatus;   
}

Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => Listofbenutzer2()), // Replace YourPage with the actual name of your page class
    );}


void function1(int userId, int rowIndex,String name,String username,String email,String password) async {
  //Wir peichern  den ursprünglichen Status, bevor wir aktualisieren.
  String initialStatus = _data[rowIndex]['status'];

  //Den Zustand optimistisch aktualisieren
  setState(() {
    rowButtonEnabledList[rowIndex] = false;
    _data[rowIndex]['status'] = 'Loeschung ausstehend';});

  try {
    final apiUrl = "http://localhost:8080/api/$userId/updateStatus3";
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'newStatus': 'Loeschung ausstehend',
      },
    );

    if (response.statusCode == 200) {
      print("Kundebetreuerstatus  erfolgreich aktualisiert");
      // Update the UI based on the actual result
      setState(() {
        // Assuming '_data' is a list and 'status' is one of its properties
        
        _data[rowIndex]['status'] = 'Loeschung ausstehend';
      });
    } else {
      print("Fehler beim Aktualisierung des Status ");
      // Revert the button state if the update fails
      setState(() {
        rowButtonEnabledList[rowIndex] = true;
        // Revert the UI change
        // Assuming 'initialStatus' is the status before the update
        _data[rowIndex]['status'] = initialStatus;
      });
    }
  } catch (e) {
    print("Fehler: $e");
    rowButtonEnabledList[rowIndex] = true;
        _data[rowIndex]['status'] = initialStatus;
    
}
Navigator.pushReplacement( context, MaterialPageRoute(builder: (BuildContext context) => Listofbenutzer2()),);
}

void function2(int userId, int rowIndex, String name, String username, String email, String password) async {
  try {
    final apiUrl = "http://localhost:8080/api/$userId/deleteUser";
    final response = await http.delete(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      print("Kunderbetreuer erfolgreich gelöscht");
    } else {
      print("Löschen des Kundebetreuer fehlgeschlagen. Statuscode: ${response.statusCode}");
    }
  } catch (e) { print("Fehler: $e"); }
  /*
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => Listofbenutzer2()), // Replace YourPage with the actual name of your page class
    );
    */
}
  
String generatePassword(int length) {
  const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
  ));
}

void _passwortzurucksetzen(int userId, int rowIndex,String name,String username,String email,String password) async {


  setState(() {
  
  });
  String initialPassword = generatePassword(8);


try{
    final serviceId = 'service_h731q5j';
    final templateId = 'template_4zpy4lr';
    final userId = 'oDcx44XpoKYGmoQ-4';



    final url = 'https://api.emailjs.com/api/v1.0/email/send';

    final Map<String, dynamic> data = {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      
      'template_params': {
        'name': name,
        'email': email,
        //'subject': subjectC.text,
        'username': username,
        'password':initialPassword,
      },
    };
  

  final response = await http.post(Uri.parse(url),
  headers: {
    'origin': 'http://localhost',
    'Content-Type': 'application/json',
  },
  body: jsonEncode(data), 
);


  print('after API Call');

  print('EmailJS Response:');
  print(response.body);

    if (response.statusCode == 200) {
     
      print('Email sent successfully!');
    } else {
      // Handle error
      print('Failed to send email. Status code: ${response.statusCode}');
    }
  
  } catch (e) {

    print('Error during API call: $e');
  }


  
final String backendUrl = 'http://localhost:8080/api/updatePassword2';


          final Map<String, String> credentials = {
      'username': username,
      'password': initialPassword,
    };

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(credentials),
      );



          if (response.statusCode == 200) {
            // Password updated successfully
            print('Password updated successfully');
            showSuccessDialog(context);

            
          } else {
            // Handle error response from the backend
            _showErrorDialog(
              context,
              'Failed to update password. Please try again.',
            );
          }
        } catch (error) {
          print('Error: $error');
          _showErrorDialog(
            context,
            'An unexpected error occurred. Please try again later.',
          );
        }
}

void showSuccessDialogFreigabe(BuildContext context,String username) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Erfolg'),
        content: Text('$username ist nun freigeschaltet'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
               Navigator.pushReplacementNamed(context, '/Listofbenutzer2');
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
void showSuccessDialogloschen(BuildContext context,String username) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Erfolg'),
        content: Text('$username  wurde erfolgreich gelöscht'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
               Navigator.pushReplacementNamed(context, '/Listofbenutzer2');
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}






void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Erfolg'),
        content: Text('Ein neues Passwort wurde generiert und  per E-Mail zugeschickt'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Useranlegen1()));
               Navigator.pushReplacementNamed(context, '/Listofbenutzer2');
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
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


