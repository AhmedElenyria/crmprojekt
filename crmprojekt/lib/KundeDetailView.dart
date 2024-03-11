import 'package:flutter/material.dart';
import 'Kunde.dart';
import 'package:intl/intl.dart';

class KundeDetailView extends StatelessWidget {
  final Kunde kunde;

  KundeDetailView({Key? key, required this.kunde}) : super(key: key);
     String geschlechtToString(Geschlecht? geschlechtSTR) {

  if (geschlechtSTR == null) {
    return "Unbekannteeee";
  }
  switch (geschlechtSTR) {
    case Geschlecht.mannlich:
      return "Männlich";
    case Geschlecht.weiblich:
      return "Weiblich";
    case Geschlecht.diverse:
      return "Divers";
    default:
      return "Unbekanntee";
  }
}
  String FamilienstatusToString(Familienstatus? familienstatus) {
if (familienstatus == null) {
    return "Unbekannteeee";
  }

    switch (familienstatus) {
      case Familienstatus.ledig:
        return "Ledig";
      case Familienstatus.verheiratet:
        return "Verheiratet";
      case Familienstatus.geschieden:
        return "Geschieden";
        case Familienstatus.verwitwet:
        return "Verwitwet";
      default:
        return "Unbekannt";
    }
  }

  String berufsgruppeToString(Berufsgruppe? berufsgruppe) {
  switch (berufsgruppe) {
    case Berufsgruppe.angestellte:
      return "angestellte";
    case Berufsgruppe.arbeiter:
      return "arbeiter";
    case Berufsgruppe.auszubildende:
      return "auszubildende";
    case Berufsgruppe.beamte:
      return "beamte";
    case Berufsgruppe.freiberufler:
      return "freiberufler";
    case Berufsgruppe.grundwehrdienst:
      return "grundwehrdienst";
    case Berufsgruppe.hausfrau:
      return "hausfrau";
    case Berufsgruppe.ohneBeschaftigung:
      return "ohne Beschäftigung";
    case Berufsgruppe.pensionar:
      return "pensionär";
    case Berufsgruppe.privatier:
      return "privatier";
    case Berufsgruppe.rentner:
      return "rentner";
    case Berufsgruppe.schuler:
      return "schüler";
    case Berufsgruppe.selbststandig:
      return "selbstständig";
    case Berufsgruppe.zeitsoldat:
      return "zeitsoldat";
    default:
      return "Unbekannt";
  }
}
String WohnartToString(Wohnart? wohnart) {
    switch (wohnart) {
      case Wohnart.Eltern:
        return "Eltern";
      case Wohnart.Miete:
        return "Miete";
      case Wohnart.Eingentum:
        return "Eingentum";
      default:
        return "Unbekannt";
    }
  }
  String produkteToString(Produkte? produkte) {
  switch (produkte) {
    case Produkte.Geldkarte:
      return "geldkarte";
    case Produkte.Kreditkarte:
      return "kreditkarte";
    case Produkte.EC_Karte:
      return "eC-Karte";
    case Produkte.Internetbanking:
      return "internetbanking";
    default:
      return "Unbekannt";
  }
}
  String NummerTypToString(NummerTyp? nummerTyp) {
    switch (nummerTyp) {
      case NummerTyp.mobil:
        return "mobil";
      case NummerTyp.privat:
        return "privat";
      case NummerTyp.geschaftlich:
        return "geschaftlich";
      default:
        return "Unbekannt";
    }
  }

  String kundenstatusToString(Kundenstatus? kundenstatus) {
  switch (kundenstatus) {
    case Kundenstatus.Kunde:
      return "Kunde";
    case Kundenstatus.Interessent:
      return "Interessent";
    case Kundenstatus.Kontaktierter_Nichtkunde:
      return "Kontaktierter Nichtkunde";
    case Kundenstatus.Kunde_im_Eroffnungsvorgang:
      return "Kunde im Eröffnungsvorgang";
    case Kundenstatus.geschlossen:
      return "Geschlossen";
    default:
      return "Unbekannt";
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kunde Details'),
      ),
     body: SingleChildScrollView( 
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

_buildDetailItem(Icons.person_outline, "Geschlecht", geschlechtToString(kunde.geschlecht)),
_buildDetailItem(Icons.title, "Titel", kunde.Titel),
_buildDetailItem(Icons.account_circle, "Name", kunde.Name),
_buildDetailItem(Icons.person_search, "Geburtsname", kunde.Geburtsname),
_buildDetailItem(Icons.perm_identity, "Vorname", kunde.Vorname),
_buildDetailItem(Icons.streetview, "Strasse", kunde.Strasse),
_buildDetailItem(Icons.markunread_mailbox, "PLZ", kunde.PLZ),
_buildDetailItem(Icons.location_city, "Ort", kunde.Ort),
_buildDetailItem(Icons.cake, "Geburtsdatum", DateFormat('dd.MM.yyyy').format(kunde.Gebursdatum)),
_buildDetailItem(Icons.flag, "Land", kunde.Land),
_buildDetailItem(Icons.public, "Staatsangehörigkeit", kunde.Staatsangehorigkeit),
_buildDetailItem(Icons.email, "Email", kunde.Email),
_buildDetailItem(Icons.family_restroom, "Familienstatus", FamilienstatusToString(kunde.familienstatus)),
_buildDetailItem(Icons.work, "Berufsgruppe", berufsgruppeToString(kunde.berufsgruppe)),
_buildDetailItem(Icons.business_center, "Selbstständig als", kunde.selbststandig),
_buildDetailItem(Icons.date_range, "Selbstständig seit", DateFormat('dd.MM.yyyy').format(kunde.selbstandingseit)),
_buildDetailItem(Icons.account_balance, "Branche", kunde.branche),
_buildDetailItem(Icons.attach_money, "Netto in €", kunde.netto,),
_buildDetailItem(Icons.child_care, "Anzahl der Kinder", kunde.AnzahlderKinde),
_buildDetailItem(Icons.home_work, "Wohnart", WohnartToString(kunde.wohnart)),
_buildDetailItem(Icons.credit_card, "Produkte", produkteToString(kunde.produkte)),
_buildDetailItem(Icons.phone_android, "Nummer Typ", NummerTypToString(kunde.nummerTyp)),
_buildDetailItem(Icons.dialpad, "Nummer", kunde.nummer),
_buildDetailItem(Icons.account_circle_outlined, "Kundenstatus", kundenstatusToString(kunde.kundenstatus)),
_buildDetailItem(Icons.confirmation_num, "Kundennummer", kunde.kundennummer),
_buildDetailItem(Icons.account_balance_wallet, "Kontonummer", kunde.kontonummer),
_buildDetailItem(Icons.check_circle_outline, "Einverstanden Werbung", kunde.einverstandenWerbungPerEmail ? 'Ja' : 'Nein'),
_buildDetailItem(Icons.security, "Einverstanden Übermittlung An Schufa", kunde.einverstandenUebermittlungAnSchufa ? 'Ja' : 'Nein'),


       ],
        ),
      ),
    ),
    );
    }
    Widget _buildDetailItem(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: TextStyle(color: Colors.blueGrey)),
    );
  }
}

