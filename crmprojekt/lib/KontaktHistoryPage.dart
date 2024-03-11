import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'KontaktEntry.dart'; 
import 'KontaktHistoryAddingPage.dart'; 
import 'KontaktDetailPage.dart';
import 'package:intl/intl.dart';

class KontaktHistoryPage extends StatefulWidget {
  @override
  _KontaktHistoryPageState createState() => _KontaktHistoryPageState();
}

class _KontaktHistoryPageState extends State<KontaktHistoryPage> {
  List<KontaktEntry> entries = [];

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/kontaktentries'));

    if (response.statusCode == 200) {
      List<dynamic> fetchedEntries = json.decode(response.body);
      setState(() {
        entries = fetchedEntries.map((e) => KontaktEntry.fromJson(e)).toList();
      });
    } else {
      // Handle error
      print("Failed to fetch entries");
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Kontakt History'),
      centerTitle: true,
      elevation: 0, // Remove shadow
    ),
    body: entries.isEmpty
        ? Center(child: Text('List der KontaktVerlauf ist leer.', style: TextStyle(fontSize: 18))) // Shows a message if the list is empty
        : Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.history, color: Theme.of(context).primaryColor),
                    title: Text(
                      '${entry.kundeVorname} ${entry.kundeName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Filiale: ${entry.filialeName}, Activity: ${entry.activityType.toString().split('.').last.replaceAll('_', ' ')}, Date: ${DateFormat('yyyy-MM-dd').format(entry.date)}',
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KontaktDetailPage(kontaktEntry: entry),
                        ),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10), // Adds spacing between cards
            ),
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => KontaktHistoryAddingPage()),
        ).then((value) => fetchEntries()); // Refresh the entries upon returning to this page
      },
      child: Icon(Icons.add),
      tooltip: 'Add Kontakt',
      backgroundColor: Theme.of(context).primaryColor, // Match with the app's primary color
    ),
  );
}
}