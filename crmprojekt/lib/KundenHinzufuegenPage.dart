//KUNDENHINZUFUGENPAGE

import 'package:crmprojekt/KundennummerService.dart';
import 'package:flutter/material.dart';
import 'Kunde.dart';
import 'Filiale.dart';
import 'package:country_picker/country_picker.dart';
import 'Bezirk.dart';
import 'KontonummerService.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'KundenService.dart';  



class KundenHinzufuegenPage extends StatefulWidget {
  final  Bezirk bezirk; 
  final Filiale filiale;
  final Kunde? kunde;
  KundenHinzufuegenPage({required this.filiale,required this.bezirk, this.kunde });

  @override
  _KundenHinzufuegenPageState createState() => _KundenHinzufuegenPageState();
  


}


DateTime Gebursdatum = DateTime.now();

class _KundenHinzufuegenPageState extends State<KundenHinzufuegenPage> {
    Future<void> sendConsentToBackend(String email, bool consent,String name,String vorname) async {
      print("sendConsentToBackend is called with email: $email and consent: $consent");
      
  final response = await http.post(
    Uri.parse('http://localhost:8080/kunde'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name':nameController.text,
      'vorname':vornameController.text,
      'email': emailController.text,
      'einverstandenWerbungPerEmail': consent,
    }),
  );

  if (response.statusCode == 200) {
    print("Consent updated successfully");
  
  } else {
   
    print("Failed to update consent with status code: ${response.statusCode}");
     print("Response body: ${response.body}");
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

    KundenService kundenService = KundenService();
    late int? id;
    late int bezirkId;
    late int filialeId;
  Geschlecht? selectedgeschlecht;
  TextEditingController TitelController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController GeburtsnameController = TextEditingController();
  TextEditingController vornameController = TextEditingController();
  TextEditingController StrasseController = TextEditingController();
  TextEditingController PLZController = TextEditingController();
  TextEditingController ORTController = TextEditingController();
  TextEditingController GebursDatumController = TextEditingController ();
  TextEditingController LandController = TextEditingController();
  TextEditingController StaatsangehorigkeitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Familienstatus? selectedfamilienstatus;
  Berufsgruppe? selectedberufsgruppe;
  TextEditingController selbststandig=TextEditingController();
  TextEditingController SelebstandigseitController=TextEditingController();
  TextEditingController BrancheController=TextEditingController();
TextEditingController netto=TextEditingController();
TextEditingController AnzahlderKindeController=TextEditingController();
Wohnart? selectedwohnart;
Produkte? selectedprodukte;
TextEditingController dispositionskreditController=TextEditingController();
  /*Map<NummerTyp, TextEditingController> nummerControllers = {
    NummerTyp.privat: TextEditingController(),
    NummerTyp.mobil: TextEditingController(),
    NummerTyp.geschaftlich: TextEditingController(),
  }; 
   NummerTyp selectedNummerTyp = NummerTyp.privat;*/
   NummerTyp? selectedNummerTyp;
   TextEditingController nummerController = TextEditingController();
    Kundenstatus? getStatusDescription;
  late String generierteKundennummer;
   late KundennummerService kundennummerService; 
   late String generiertekontonummer;
   late KontonummerService kontonummerService; 
  
    bool werbungZustimmung = false;
  bool schufaEinwilligung = false;
  bool SentGeburtsdatum=false;
  

  

  @override
void initState() {
  super.initState();
    bezirkId = widget.bezirk.id;
  filialeId = widget.filiale.id;
  id=widget.kunde?.id;
  kundennummerService = KundennummerService();
  generierteKundennummer = kundennummerService.generateKundennummer(widget.filiale);
  kontonummerService= KontonummerService();
  generiertekontonummer = kontonummerService.generateKontonummer(widget.filiale);
}
 void _handleAddKunde() async {
    try {
      
    DateTime parsedGeburtsdatum = DateTime.tryParse(GebursDatumController.text) ?? DateTime.now(); 
     DateTime parsedSelbstandigSeit = DateTime.tryParse(SelebstandigseitController.text) ?? DateTime.now();
      
      Kunde neuerKunde = Kunde(
        id: id ,
        bezirkId: bezirkId,
        filialeId: filialeId,
        geschlecht: selectedgeschlecht,
        Titel: TitelController.text,
        Name: nameController.text,
        Geburtsname: GeburtsnameController.text,
        Vorname: vornameController.text,
        Strasse: StrasseController.text,
        PLZ: PLZController.text,
        Ort: ORTController.text,
        Gebursdatum: parsedGeburtsdatum,
       Land: LandController.text,
        Staatsangehorigkeit: StaatsangehorigkeitController.text,
        Email:   emailController.text,
        familienstatus:   selectedfamilienstatus,
        berufsgruppe: selectedberufsgruppe,
        selbststandig:  selbststandig.text,
        selbstandingseit:parsedSelbstandigSeit, 
        branche:  BrancheController.text,
        netto  : netto.text,
        AnzahlderKinde:  AnzahlderKindeController.text,
        wohnart:  selectedwohnart,
        produkte:  selectedprodukte,
        nummerTyp: selectedNummerTyp,
         nummer: nummerController.text,
      kundenstatus: getStatusDescription,
      kundennummer: generierteKundennummer,
      kontonummer: generiertekontonummer,
      einverstandenWerbungPerEmail: werbungZustimmung,
      einverstandenUebermittlungAnSchufa: schufaEinwilligung,    
      emailSentForBirthday:SentGeburtsdatum,   
      );
       await kundenService.addKunde(neuerKunde);
   

       

      Navigator.pop(context); // Navigate back or update your list
    } catch (e) {
      // Handle error, e.g., show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler: $e')),
      );
    }
  }
 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kunde zur Filiale hinzufügen'),
        backgroundColor: Colors.blue, // Hintergrundfarbe der App-Leiste
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildGeschlecht(),
              _buildTextField(TitelController, 'Titel(optional):'),
              _buildTextField(nameController, 'Name*:'),
              _buildTextField(GeburtsnameController, 'Geburtsname(optinal)'),
              _buildTextField(vornameController, 'Vorname*:'),
              _buildTextField(StrasseController, 'Strasse*:'),
              _buildTextField(PLZController, 'PLZ*:'),
              _buildTextField(ORTController, 'Ort*:'),
              _buildDatePickerField(GebursDatumController, 'Geburtsdatum*:'),
              _buildTextField(LandController, 'Land* :', onTap: _showCountryPickerDialog),
              _buildTextField(StaatsangehorigkeitController, 'Staatsangehorigkeit* :', onTap: _showCountryPickerDDialog),
              _buildTextField(emailController, 'E-Mail-Adresse* :', keyboardType: TextInputType.emailAddress),
              _buildFamilienstatusField(),
              _buildBerfusgruppe(),
              _buildTextField(selbststandig, 'Selbständig als* : '),
              _buildDatePickerFieldd(SelebstandigseitController, 'Selbstandig Seit* : '),
              _buildTextField(BrancheController, 'Branche(Schlüssel)* : '),
              _buildTextField(netto,'netto*: €'),
              _buildTextField(AnzahlderKindeController, 'Anzahl der im Haushalt lebenden unterhaltsberechtigten Kinder* :'),
              _buildWohnart(),
              _buildProdukte(),
              _buildNummerTyp(),
  _buildTextField(nummerController, 'Nummer:* '),
  _buildKundenStatus(),
  _buildKundennummerField(generierteKundennummer),
  _buildkontonummerField(generiertekontonummer),
              _buildWerbungZustimmung(),
              _buildSchufaEinwilligung(),
              _buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }
  

    Widget  _buildNummerTyp() {
    return TextField(
      controller: TextEditingController(text: selectedNummerTyp?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'NummerTyp*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showNummerTypDialog(context);
      },
    );
  }
    Future<void> _showNummerTypDialog(BuildContext context) async {
    NummerTyp? selectedStatus = await showDialog<NummerTyp>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('NummerTyp auswählen'),
          content: Column(
            children: NummerTyp.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        selectedNummerTyp= selectedStatus;
      });
    }
  }

 Widget _buildKundennummerField(String kundennummer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(
          'Kundennummer:',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          kundennummer,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
 Widget _buildkontonummerField(String kontonummer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Text(
          'Kontonummer:',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.0),
        Text(
         kontonummer,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
  
  Widget _buildTextField(TextEditingController controller, String labelText,
      {VoidCallback? onTap, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blue), 
      ),
      onTap: onTap,
      keyboardType: keyboardType,
    );
  }

 Widget _buildDatePickerField(TextEditingController controller, String labelText) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.blue),
    ),
    onTap: () async {
      DateTime currentDate = DateTime.now();
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 100),
        lastDate: currentDate,
      );

      if (pickedDate != null) {
        int age = currentDate.year - pickedDate.year;

        if (currentDate.month < pickedDate.month ||
            (currentDate.month == pickedDate.month && currentDate.day < pickedDate.day)) {
          age--;
        }

        if (age >= 18) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sie müssen älter als 18 Jahre sein.'),
            ),
          );
        }
      }
    },
  );
}

   Widget _buildDatePickerFieldd(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null && pickedDate != selbststandig) {
           SelebstandigseitController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
    );
  }

  Widget _buildGeschlecht() {
    return TextField(
      controller: TextEditingController(text: selectedgeschlecht?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Geschlecht*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showgeschlechtDialog(context);
      },
    );
  }
   Widget _buildKundenStatus() {
    return TextField(
      controller: TextEditingController(text: getStatusDescription?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'KundenStatus*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showKundenStatusDialog(context);
      },
    );
  }
  Widget _buildProdukte() {
    return TextField(
      controller: TextEditingController(text: selectedprodukte?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Produkte*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showProdukteDialog(context);
      },
    );
  }


  Widget _buildFamilienstatusField() {
    return TextField(
      controller: TextEditingController(text: selectedfamilienstatus?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Familienstatus*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showFamilienstatusDialog(context);
      },
    );
  }
  Widget _buildWohnart() {
    return TextField(
      controller: TextEditingController(text: selectedwohnart?.toString() .split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Wohnart*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showWohnartDialog(context);
      },
    );
  }
    Widget _buildBerfusgruppe() {
    return TextField(
      controller: TextEditingController(text: selectedberufsgruppe?.toString().split('.').last ?? ''),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Berufsgruppe*: ',
        suffixIcon: Icon(Icons.arrow_drop_down),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _showBerufsgruppeDialog(context);
      },
    );
  }

  Widget _buildWerbungZustimmung() {
    return Row(
      children: [
        Checkbox(
          value: werbungZustimmung,
          onChanged: (value) {
            setState(() {
              werbungZustimmung = value ?? false;
            });
          },
        ),
        Text('Einverständnis Werbung per E-Mail '),
      ],
    );
  }

  Widget _buildSchufaEinwilligung() {
    return Row(
      children: [
        Checkbox(
          value: schufaEinwilligung,
          onChanged: (value) {
            setState(() {
              schufaEinwilligung = value ?? false;
            });
          },
        ),
        Text('Schufa-Einwilligung'),
      ],
    );
  }



  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () async {



        
        if (_areRequiredFieldsFilled())
         {
          if(_isValidEmail()){
          Kunde neuerKunde = Kunde(
            id:id,
            bezirkId: bezirkId,
            filialeId: filialeId,
            geschlecht: selectedgeschlecht,
            Titel: TitelController.text,
            Name: nameController.text,
            Geburtsname: TitelController.text,
            Vorname: vornameController.text,
            Strasse: StrasseController.text,
            PLZ: PLZController.text,
            Ort: ORTController.text,
            Gebursdatum: DateTime.parse(GebursDatumController.text),
            Land: LandController.text,
            Staatsangehorigkeit: StaatsangehorigkeitController.text,
            Email: emailController.text,
            familienstatus: selectedfamilienstatus,
            berufsgruppe: selectedberufsgruppe,
            selbststandig: selbststandig.text,
            selbstandingseit: DateTime.parse(SelebstandigseitController.text),
            branche: BrancheController.text,
            netto: netto.text,
            AnzahlderKinde: AnzahlderKindeController.text,
            wohnart: selectedwohnart,
            produkte: selectedprodukte,
          nummerTyp: selectedNummerTyp,
          nummer: nummerController.text,
          kundenstatus: getStatusDescription,
           kundennummer: generierteKundennummer,
           kontonummer: generiertekontonummer,
     
            einverstandenWerbungPerEmail: werbungZustimmung,
            einverstandenUebermittlungAnSchufa: schufaEinwilligung,
            emailSentForBirthday: SentGeburtsdatum
        );
        try {
  await KundenService().addKunde(neuerKunde);

  if (neuerKunde.einverstandenWerbungPerEmail) {
    await sendEmail(neuerKunde.Name, emailController.text);
  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Marketing-E-Mail erfolgreich gesendet')),
    );
  }
  // Navigate back and show success message
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Kunde erfolgreich hinzugefügt')),
  );
} catch (e) {
  // Show error message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Fehler beim Hinzufügen des Kunden: $e')),
  );
}

          await  sendConsentToBackend(emailController.text, neuerKunde.einverstandenWerbungPerEmail,nameController.text,vornameController.text);

         Navigator.pop(context);
          }else
          {ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bitte geben Sie eine gültige Email Adresse ein.'),
            ),
          );

          }

  
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bitte fülen Sie alle Felder aus.'),
            ),
          );
        }
      },
      child: Text(
        'Kunde hinzufügen',
        style: TextStyle(color: Colors.white), // Farbe für den Text des Buttons
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Hintergrundfarbe des Buttons
      ),
    );
  }
  bool _areRequiredFieldsFilled() {
  return nameController.text.isNotEmpty &&
      vornameController.text.isNotEmpty &&
      StrasseController.text.isNotEmpty &&
      PLZController.text.isNotEmpty &&
      ORTController.text.isNotEmpty &&
      GebursDatumController.text.isNotEmpty &&
      LandController.text.isNotEmpty &&
      StaatsangehorigkeitController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      selectedfamilienstatus != null &&
      selectedberufsgruppe != null &&
      selbststandig.text.isNotEmpty &&
      SelebstandigseitController.text.isNotEmpty &&
      BrancheController.text.isNotEmpty &&
      netto.text.isNotEmpty &&
      AnzahlderKindeController.text.isNotEmpty &&
      selectedwohnart != null &&
      selectedprodukte != null;
}

  void _showCountryPickerDialog() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          LandController.text = country.displayNameNoCountryCode;
        });
      },
    );
  }
  void _showCountryPickerDDialog() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          StaatsangehorigkeitController.text= country.displayNameNoCountryCode;
        });
      },
    );
  }

  Future<void> _showFamilienstatusDialog(BuildContext context) async {
    Familienstatus? selectedStatus = await showDialog<Familienstatus>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Familienstatus auswählen'),
          content: Column(
            children: Familienstatus.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        selectedfamilienstatus = selectedStatus;
      });
    }
  }
  Future<void> _showProdukteDialog(BuildContext context) async {
    Produkte? selectedStatus = await showDialog<Produkte>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prudkte auswählen'),
          content: Column(
            children: Produkte.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        selectedprodukte = selectedStatus;
      });
    }
  }
   Future<void> _showWohnartDialog (context) async {
    Wohnart? selectedStatus = await showDialog<Wohnart>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wohnart auswählen'),
          content: Column(
            children: Wohnart.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        selectedwohnart = selectedStatus;
      });
    }
  }
  Future<void> _showKundenStatusDialog(context) async {
    Kundenstatus? selectedStatus = await showDialog<Kundenstatus>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('KundenStatus auswählen:'),
          content: Column(
            children: Kundenstatus.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        getStatusDescription = selectedStatus;
      });
    }
  }

  

  Future<void> _showgeschlechtDialog(BuildContext context) async {
    Geschlecht? selectedStatus = await showDialog<Geschlecht>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Geschlecht auswählen'),
          content: Column(
            children: Geschlecht.values.map((status) {
              return ListTile(
                title: Text(status.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, status);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        selectedgeschlecht = selectedStatus;
      });
    }
  }

  bool _isValidEmail() {
    String email = emailController.text;
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  
Future<void> _showBerufsgruppeDialog(BuildContext context) async {
  Berufsgruppe? selectedStatus = await showDialog<Berufsgruppe>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Berufsgruppe auswählen'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: Berufsgruppe.values.length,
            itemBuilder: (BuildContext context, int index) {
              Berufsgruppe gruppe = Berufsgruppe.values[index];
              return ListTile(
                title: Text(gruppe.toString().split('.').last),
                onTap: () {
                  Navigator.pop(context, gruppe);
                },
              );
            },
          ),
        ),
      );
    },
  );

  if (selectedStatus != null) {
    setState(() {
      selectedberufsgruppe = selectedStatus;
    });
  }
    
  




}
}
