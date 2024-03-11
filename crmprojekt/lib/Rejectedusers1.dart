import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';


Future<List<Map<String, dynamic>>> fetchData() async {
const apiUrl = "http://localhost:8080/api/getallusers";

  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    print("Erfolgreich");
    List<dynamic> data = json.decode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Fehler beim Laden der daten');
  }
}


class Rejectedusers1 extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<Rejectedusers1> {
  List<Map<String, dynamic>> _data = [];
  List<bool> rowButtonEnabledList = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
         _data = data.where((rowData) => (rowData['status'] != 'aktiv' && rowData['status'] != 'Aktivierung ausstehend' && rowData['status'] != 'Loeschung ausstehend') && rowData['admin']=='admin1').toList();

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
          'Liste der abgelehnte  Kundenbetreuer',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Adjust the color as needed
          ),
        ),
      ),
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
                'Passwort',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),*/
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Grund',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Option 1',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            /*
            DataColumn(
              label: Text(
                'Option 3',
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
            ),*/
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
                DataCell(Text('Abgelehnt')),




                /*DataCell(
                  ElevatedButton(
                    onPressed: rowButtonEnabledList[index] &&
                        (rowData['admin'] == "admin2" && rowData['status'] == "Aktivierung ausstehend")
                        ? () => _handleFreigeben(rowData['id'], index,rowData['name'],rowData['username'],rowData['email'],rowData['password'])
                        : null,
                    child: Text('Freigeben'),
                  ),
                ),
                DataCell(ElevatedButton(onPressed: () {}, child: Text('Ablehnen'))),
                DataCell(ElevatedButton(onPressed: () {}, child: Text('Passwort zurücksetzen'))),
                */
                DataCell(Text(rowData['status'])),
                DataCell(
                /*ElevatedButton(
                                   onPressed: rowButtonEnabledList[index] && ((rowData['status'] == "Abgelehnt") || 
                                  (rowData['admin'] == "admin2" && rowData['status'] == "Loeschung ausstehend" )) ? () {
              function1(rowData['id'], index, rowData['name'], rowData['username'], rowData['email'], rowData['password']);
            
          }*/
          ElevatedButton(
  onPressed: () {
   function1(context,rowData['id'], index, rowData['name'], rowData['username'], rowData['email'], rowData['password']);
 ;
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.red,
    onPrimary: Colors.white, 
    padding: EdgeInsets.all(15.0), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), 
    ),
  ),
  child: Text('Löschen'),
          )
    ),

                /*DataCell(
  Text(
    rowData['edatum'] != null
        ? DateFormat('yyyy.MM.dd').format(DateTime.parse(rowData['edatum']).toLocal())
        : 'Warten auf Aktivierung',
    style: TextStyle(fontSize: 14), // Adjust the font size as needed
  ),
),

DataCell(
  Text(
    rowData['edatum'] != null
        ? DateFormat('yyyy.MM.dd').format(DateTime.parse(rowData['adatum']).toLocal())
        : 'Warten auf Aktivierung',
    style: TextStyle(fontSize: 14), // Adjust the font size as needed
  ),
),
*/
              ],
            );
          }).toList(),
        ),
      ),
    ),
  );
}
}
/*
void function1(int userId, int rowIndex, String name, String username, String email, String password) async {
  try {
    final apiUrl = "http://localhost:8080/api/$userId/deleteUser"; // Adjust the URL to your endpoint
    final response = await http.delete(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      print("User deleted successfully");
    } else {
      print("Failed to delete user. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  Navigator.pushReplacement(
      context ,MaterialPageRoute(builder: (BuildContext context) => Rejectedusers1()), // Replace YourPage with the actual name of your page class
    );

}

*/
void function1(BuildContext context, int userId, int rowIndex, String name, String username, String email, String password) async {
  try {
    final apiUrl = "http://localhost:8080/api/$userId/deleteUser"; // Adjust the URL to your endpoint
    final response = await http.delete(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      print("User deleted successfully");
    } else {
      print("Failed to delete user. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  }
  
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (BuildContext context) => Rejectedusers1()),
  );
}

