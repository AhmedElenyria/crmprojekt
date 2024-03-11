import 'package:flutter/material.dart';
import 'Kunde.dart';  
import  'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';




class KundeEditPage extends StatefulWidget {
 
  final Kunde kunde;

  KundeEditPage({required this.kunde});

  @override
  _KundeEditPageState createState() => _KundeEditPageState();
}

class _KundeEditPageState extends State<KundeEditPage> {
  void showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Bestätigung"),
        content: Text("Sind Sie sicher, dass Sie diesen Kunden löschen möchten?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Nein'),
          ),
          TextButton(
            onPressed: () {
              
              deleteKunde();
              Navigator.of(context).pop();
            },
            child: Text('Ja'),
          ),
        ],
      );
    },
  );
}
Future<void> sendConsentToBackend(String email, bool consent,String name,String Vorname) async {
      
  final response = await http.post(
    Uri.parse('http://localhost:8080/kunde'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': widget.kunde.Name,
      'vorname':widget.kunde.Vorname,
      'email': emailController.text,
      'einverstandenWerbungPerEmail': consent,
    }),
  );

  if (response.statusCode == 200) {
    print("Consent updated successfully");
   
  } else {
    // Handle error
    print("Failed to update consent with status code: ${response.statusCode}");
     print("Response body: ${response.body}");
  }
}

   DateTime? selectedSelbstaendigSeit;
  late TextEditingController titelController;
  late TextEditingController emailController;
  late TextEditingController strasseController;
  late TextEditingController ortController;
  late TextEditingController plzController;
  late TextEditingController selbststaendigController;
  late TextEditingController selbstaendigSeitController;
  late TextEditingController brancheController;
  late TextEditingController nettoController;
  late TextEditingController anzahlderKindeController;
  late TextEditingController nummerController;

  Berufsgruppe? selectedBerufsgruppe;
  Wohnart? selectedWohnart;
  Produkte? selectedProdukte;
  Kundenstatus? selectedKundenstatus;
  Familienstatus? selectedFamilienstatus;
  NummerTyp? selectedNummerTyp;

  late bool einverstandenWerbungPerEmail;
  late  bool einverstandenUebermittlungAnSchufa;

  @override
  void initState() {
    super.initState();
    titelController = TextEditingController(text: widget.kunde.Titel);
    emailController = TextEditingController(text: widget.kunde.Email);
    strasseController = TextEditingController(text: widget.kunde.Strasse);
    ortController = TextEditingController(text: widget.kunde.Ort);
    plzController = TextEditingController(text: widget.kunde.PLZ);
   
    selbststaendigController = TextEditingController(text: widget.kunde.selbststandig);
     //selbstaendigSeitController = TextEditingController(text: widget.kunde.selbstandingseit != null ? DateFormat('yyyy-MM-dd').format(widget.kunde.selbstandingseit!) : '');
     selectedSelbstaendigSeit=widget.kunde.selbstandingseit;

    
    brancheController = TextEditingController(text: widget.kunde.branche);
    nettoController = TextEditingController(text: widget.kunde.netto);
    anzahlderKindeController = TextEditingController(text: widget.kunde.AnzahlderKinde);
    nummerController = TextEditingController(text: widget.kunde.nummer);

    selectedBerufsgruppe = widget.kunde.berufsgruppe;
    selectedWohnart = widget.kunde.wohnart;
    selectedProdukte = widget.kunde.produkte;
    selectedKundenstatus = widget.kunde.kundenstatus;
    selectedFamilienstatus = widget.kunde.familienstatus;
    selectedNummerTyp = widget.kunde.nummerTyp;

    einverstandenWerbungPerEmail = widget.kunde.einverstandenWerbungPerEmail;
    einverstandenUebermittlungAnSchufa = widget.kunde.einverstandenUebermittlungAnSchufa;
  }

  @override
  void dispose() {
    titelController.dispose();
    emailController.dispose();
    strasseController.dispose();
    ortController.dispose();
    plzController.dispose();
    selbststaendigController.dispose();
    selbstaendigSeitController?.dispose();
    brancheController.dispose();
    nettoController.dispose();
    anzahlderKindeController.dispose();
    nummerController.dispose();
    super.dispose();
  }

 
    Future<void> _selectSelbstaendigSeit(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedSelbstaendigSeit ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (picked != null && picked != selectedSelbstaendigSeit) {
    setState(() {
      selectedSelbstaendigSeit = picked;
    });
  }
}
 Future<void> updateKunde() async {
  try {

    String formattedDate = selectedSelbstaendigSeit != null 
      ? DateFormat('yyyy-MM-dd').format(selectedSelbstaendigSeit!) 
      : '';
     var updatedData = {
      'titel': titelController.text,
      'email': emailController.text,
      'strasse' : strasseController.text,
      'ort': ortController.text,
      'plz': plzController.text,
      'selbststandig':selbststaendigController.text,
      'selbstandingseit':  formattedDate, 
      'branche':brancheController.text,
      'netto': nettoController.text,
      'anzahlderKinde': anzahlderKindeController.text,
      'nummer' :nummerController.text,
      'berufsgruppe': selectedBerufsgruppe?.toString().split('.').last,
      'familienstatus': selectedFamilienstatus?.toString().split('.').last,
      'wohnart': selectedWohnart?.toString().split('.').last,
      'produkte':  selectedProdukte?.toString().split('.').last,
      'nummerTyp': selectedNummerTyp?.toString().split('.').last,
      'kundenStatus':selectedKundenstatus?.toString().split('.').last,
  'einverstandenWerbungPerEmail': einverstandenWerbungPerEmail,
      'einverstandenUebermittlungAnSchufa': einverstandenUebermittlungAnSchufa,
     };
      String jsonBody = jsonEncode(updatedData);
      var url = Uri.parse('http://localhost:8080/kunde/${widget.kunde.id}');
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );
    if (response.statusCode == 200) {
    
       print("Update successful");

      //  benutz_build_context_synchronously
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Update successfully"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle failure
      print("Failed to update");
    }
  } catch (e) {
    // Handle any errors during the update
     print("Error occurred: $e");
  }
}
Future<void> deleteKunde() async {
  final url = Uri.parse('http://localhost:8080/kunde/${widget.kunde.id}');
  final response = await http.delete(url);

  if (response.statusCode == 204) {
    // Optionally, show a success message or navigate away
    Navigator.of(context).pop(); // Go back to the previous screen
  } else {
    // Handle errors or unsuccessful deletion
    print("Failed to delete the Kunde. Status Code: ${response.statusCode}. Response Body: ${response.body}");
  }
}
Future<void> sendEmail(String name,String email) async {
    try {
      final serviceId = 'service_vnqbr73';
      final templateId = 'template_vq2vqa2';
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
        headers: {'origin': 'http://localhost','Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      //print('EmailJS Response:');
      //print(response.body);

      if (response.statusCode == 200) {
      print('E-Mail erfolgreich versendet!');
      } else {print('Fehler beim Versenden der E-Mail. Statuscode: ${response.statusCode}');}
} catch (e){print('Fehler bei der API-Aufruf: $e');}
  }
  Future<void> sendAbsageEmail(String name,String email) async {
    try {
      final serviceId = 'service_iklep0o';
      final templateId = 'template_m22cqu4';
      final userId = 'l9XVmRtMbPS0rR0Tm';
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
        headers: {'origin': 'http://localhost','Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      //print('EmailJS Response:');
      //print(response.body);

      if (response.statusCode == 200) {
      print('E-Mail erfolgreich versendet!');
      } else {print('Fehler beim Versenden der E-Mail. Statuscode: ${response.statusCode}');}
} catch (e){print('Fehler bei der API-Aufruf: $e');}
  }

 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kunde'),
        backgroundColor: Colors.blue, // Use theme color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
   
            // Non-editable fields
             Text('name: ${widget.kunde.Name}'),
          Text('vorname: ${widget.kunde.Vorname}'),
          Text('geburtsname: ${widget.kunde.Geburtsname}'),
          Text('geschlecht: ${widget.kunde.geschlecht?.toString() ?? "N/A"}'),
         Text('geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.kunde.Gebursdatum)}'),

          Text('land: ${widget.kunde.Land}'),
          Text('staatsangehörigkeit: ${widget.kunde.Staatsangehorigkeit}'),
          Text('kundennummer: ${widget.kunde.kundennummer}'),
          Text('kontonummer: ${widget.kunde.kontonummer}'),
             
             TextField(controller: titelController, decoration: InputDecoration(labelText: 'titel')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'email')),
             TextField(controller: strasseController, decoration: InputDecoration(labelText: 'strasse')),
              TextField(controller: ortController, decoration: InputDecoration(labelText: 'ort')),
               TextField(controller: plzController, decoration: InputDecoration(labelText: 'plz')),
              
                 TextField(controller: selbststaendigController, decoration: InputDecoration(labelText: 'selbststandig')),
                  TextField(controller: brancheController, decoration: InputDecoration(labelText: 'branche')),
                   TextField(controller: nettoController, decoration: InputDecoration(labelText: 'netto')),
                    TextField(controller: anzahlderKindeController, decoration: InputDecoration(labelText: 'anzahlderKinde')),
                     TextField(controller: nummerController, decoration: InputDecoration(labelText: 'nummer')),
                     
            
        
            
            ListTile(
  title: Text(
    'selbstandingseit: ${selectedSelbstaendigSeit != null ? DateFormat('dd.MM.yyyy').format(selectedSelbstaendigSeit!) : 'N/A'}'
  ),
  onTap: () => _selectSelbstaendigSeit(context),
  
),

         Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<Berufsgruppe>(
    decoration: InputDecoration(
      labelText: 'berufsgruppe',
      border: OutlineInputBorder(),
    ),
    value: selectedBerufsgruppe,
    onChanged: (Berufsgruppe? newValue) {
      setState(() {
        selectedBerufsgruppe = newValue;
      });
    },
    items: Berufsgruppe.values.map<DropdownMenuItem<Berufsgruppe>>((Berufsgruppe value) {
      return DropdownMenuItem<Berufsgruppe>(
        value: value,
        child: Text(value.toString().split('.').last), // For better readability
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a Berufsgruppe';
      }
      return null; // Return null if the input is valid
    },
  ),
),


                Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<Wohnart>(
    decoration: InputDecoration(
      labelText: 'wohnart',
      border: OutlineInputBorder(),
    ),
    value: selectedWohnart,
    onChanged: (Wohnart? newValue) {
      setState(() {
        selectedWohnart = newValue;
      });
    },
    items: Wohnart.values.map<DropdownMenuItem<Wohnart>>((Wohnart value) {
      return DropdownMenuItem<Wohnart>(
        value: value,
        child: Text(value.toString().split('.').last), // For better readability
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a Wohnart';
      }
      return null; // Return null if the input is valid
    },
  ),
),

                        Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<Produkte>(
    decoration: InputDecoration(
      labelText: 'produkte',
      border: OutlineInputBorder(),
    ),
    value: selectedProdukte,
    onChanged: (Produkte? newValue) {
      setState(() {
        selectedProdukte = newValue;
      });
    },
    items: Produkte.values.map<DropdownMenuItem<Produkte>>((Produkte value) {
      return DropdownMenuItem<Produkte>(
        value: value,
        child: Text(value.toString().split('.').last), // For better readability
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a Produkt';
      }
      return null; // Return null if the input is valid
    },
  ),
),

        
                        Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<Kundenstatus>(
    decoration: InputDecoration(
      labelText: 'kundenStatus',
      border: OutlineInputBorder(),
    ),
    value: selectedKundenstatus,
    onChanged: (Kundenstatus? newValue) {
      setState(() {
        selectedKundenstatus = newValue;
      });
    },
    items: Kundenstatus.values.map<DropdownMenuItem<Kundenstatus>>((Kundenstatus value) {
      return DropdownMenuItem<Kundenstatus>(
        value: value,
        child: Text(value.toString().split('.').last), // For better readability
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a KundenStatus';
      }
      return null; // Return null if the input is valid
    },
  ),
),
          
          Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<Familienstatus>(
    decoration: InputDecoration(
      labelText: 'familienstatus',
      border: OutlineInputBorder(),
    ),
    value: selectedFamilienstatus,
    onChanged: (Familienstatus? newValue) {
      setState(() {
        selectedFamilienstatus = newValue;
      });
    },
    items: Familienstatus.values.map<DropdownMenuItem<Familienstatus>>((Familienstatus value) {
      return DropdownMenuItem<Familienstatus>(
        value: value,
        child: Text(value.toString().split('.').last), // For better readability
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a FamilienStatus';
      }
      return null; // Return null if the input is valid
    },
  ),
),

  
                        Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: DropdownButtonFormField<NummerTyp>(
    decoration: InputDecoration(
      labelText: 'nummerTyp',
      border: OutlineInputBorder(),
    ),
    value: selectedNummerTyp,
    onChanged: (NummerTyp? newValue) {
      setState(() {
        selectedNummerTyp = newValue;
      });
    },
    items: NummerTyp.values.map<DropdownMenuItem<NummerTyp>>((NummerTyp value) {
      return DropdownMenuItem<NummerTyp>(
        value: value,
        child: Text(value.toString().split('.').last), 
      );
    }).toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select a NummerTyp';
      }
      return null; 
    },
  ),
),
           SwitchListTile(
            title: const Text('Einverstanden Werbung Per Email'),
            value: einverstandenWerbungPerEmail,
            onChanged: (bool newValue) {
              setState(() {
                einverstandenWerbungPerEmail = newValue;
              });
            },
          ),
           SwitchListTile(
            title: const Text('Einverstanden Übermittlung An Schufa'),
            value: einverstandenUebermittlungAnSchufa,
            onChanged: (bool newValue) {
              setState(() {
                einverstandenUebermittlungAnSchufa = newValue;
              });
            },
          ),
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
         ElevatedButton(
  onPressed: () {
    updateKunde();
    sendConsentToBackend(emailController.text, einverstandenWerbungPerEmail, widget.kunde.Name, widget.kunde.Vorname);
    if (einverstandenWerbungPerEmail) {
      sendEmail(widget.kunde.Name, emailController.text);
    }
    else if (!einverstandenWerbungPerEmail){
      sendAbsageEmail(widget.kunde.Name, emailController.text);
    }
  },
  child: Text('Update Kunde'),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  ),
),
      
           ElevatedButton(
      onPressed: () => showDeleteConfirmationDialog(context),
      child: Text('Delete Kunde'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
    ),
    
     ],
),
          ],
        ),
      ),
    );
  }
   

 
  
}




