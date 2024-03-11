

enum Kundenstatus{
  Kunde, 
  Interessent, 
  Kontaktierter_Nichtkunde, 
  Kunde_im_Eroffnungsvorgang, 
  geschlossen
}
enum Produkte{
  Geldkarte,
  Kreditkarte,
  EC_Karte,
  Internetbanking, 
}
enum Wohnart{
  Eltern,
  Miete,
  Eingentum,
}
enum Berufsgruppe {
  angestellte,
  arbeiter,
  auszubildende,
  beamte,
  freiberufler,
  grundwehrdienst,
  hausfrau,
  ohneBeschaftigung,
  pensionar,
  privatier,
  rentner,
  schuler,
  selbststandig,
  zeitsoldat,
}


enum NummerTyp{
mobil,
 privat,
 geschaftlich, 
}


enum Familienstatus {
  ledig,
  verheiratet,
  geschieden,
  verwitwet,
}
enum Geschlecht{
  mannlich,
  weiblich,
  diverse,
}
enum Einverstaendnis {
  werbungPerEmail,
  uebermittlungAnSchufa,
}

class Kunde {
  final int? id;
  final int bezirkId;
  final int filialeId;
  Geschlecht? geschlecht;
  String Titel;
  String Name;
  String Geburtsname;
  String Vorname;
  String Strasse;
  String PLZ;
  String Ort;
  DateTime Gebursdatum;
  String Land;
  String Staatsangehorigkeit;
  String Email;
  Familienstatus? familienstatus;
  Berufsgruppe? berufsgruppe;
  String selbststandig;
  DateTime selbstandingseit;
 final String branche;
String netto;
final String AnzahlderKinde;
Wohnart? wohnart;
Produkte? produkte;
 
//final Map<NummerTyp, String> nummern;
NummerTyp ? nummerTyp;
String nummer;
Kundenstatus ? kundenstatus;
final String kundennummer;
final String kontonummer;
  bool einverstandenWerbungPerEmail;
  bool einverstandenUebermittlungAnSchufa;
  bool emailSentForBirthday;

  Kunde({
    required this.id,
    required this.bezirkId,
    required this.filialeId,
    required this.geschlecht,
    required this.Titel,
    required this.Name,
    required this.Geburtsname,
    required this.Vorname,
    required this.Strasse,
    required this.PLZ,
    required this.Ort,
    required this.Gebursdatum,
    required this.Land,
    required this.Staatsangehorigkeit,
    required this.Email,
    required this.familienstatus,
    required this.berufsgruppe,
    required this.selbststandig,
    required this.selbstandingseit,
    required this.branche,
    required this.netto,
    required this.AnzahlderKinde,
    required this.wohnart,
    required this.produkte,
    required this.nummerTyp,
    required this.nummer,
    required this.kundenstatus,
    required this.kundennummer,
    required this.kontonummer,
    required this.einverstandenWerbungPerEmail,
    required this.einverstandenUebermittlungAnSchufa,
    required this.emailSentForBirthday,
    
  });
 Map<String, dynamic> toMap() {
    return {
      'id':id,
      'bezirkId':bezirkId,
      'filialeId': filialeId,
      //'geschlecht': geschlecht?.toString(), // Convert enum to string or int as needed
      'geschlecht': geschlecht?.toString().split('.').last,
      'titel': Titel,
      'name': Name,
      'geburtsname': Geburtsname,
      'vorname': Vorname,
      'strasse': Strasse,
      'plz': PLZ,
      'ort': Ort,
      'geburtsdatum': Gebursdatum.toIso8601String(), // Convert DateTime to string
      'land': Land,
      'staatsangehorigkeit': Staatsangehorigkeit,
      'email': Email,
      'familienstatus': familienstatus?.toString().split('.').last,
      'berufsgruppe': berufsgruppe?.toString().split('.').last,
      'selbststandig': selbststandig,
      'selbstandingseit': selbstandingseit.toIso8601String(), // Convert DateTime to string
      'branche': branche,
      'netto': netto,
      'anzahlderKinde': AnzahlderKinde,
      'wohnart': wohnart?.toString().split('.').last,
      'produkte': produkte?.toString().split('.').last,
      'nummerTyp':nummerTyp?.toString().split('.').last,
      'nummer':nummer,
      'kundenStatus': kundenstatus?.toString().split('.').last,
      'kundennummer': kundennummer,
      'kontonummer': kontonummer,
      'einverstandenWerbungPerEmail': einverstandenWerbungPerEmail,
      'einverstandenUebermittlungAnSchufa': einverstandenUebermittlungAnSchufa,
      'emailSentForBirthday': emailSentForBirthday,
    };
    
  }
    static Geschlecht? parseGeschlecht(String? geschlechtStr) {
    if (geschlechtStr == null) {
      return null; // Return null or handle it as needed
    }
    String formattedGeschlechtStr = geschlechtStr.replaceAll('"', '');
    for (var geschlecht in Geschlecht.values) {
      //if ('geschlecht.$geschlechtStr' == geschlecht.toString()) {
        if (geschlecht.toString().split('.').last.toLowerCase() == formattedGeschlechtStr.toLowerCase()) {
        return geschlecht;
      }
    }
    return null; // Return null or handle unexpected string case as needed
  }
 static Familienstatus? parseFamilienstatus(String? familienStr) {
    if (familienStr == null) {
      return null; // Return null or handle it as needed
    }
    String formattedFamilien = familienStr.replaceAll('"', '');
    for (var familienstatus in Familienstatus.values) {
      //if ('familienstatus.$familienStr' == familienstatus.toString()) {
         if (familienstatus.toString().split('.').last.toLowerCase() == formattedFamilien.toLowerCase()) {
        return familienstatus;
      }
    }
    return null; // Return null or handle unexpected string case as needed
  }
static Berufsgruppe? parseBerufsgruppe(String? BerufsStr) {
    if (BerufsStr == null) {
      return null; // Return null or handle it as needed
    }
     String formattedBerufsgruppe = BerufsStr.replaceAll('"', '');
    for (var berufsgruppe in Berufsgruppe.values) {
       if (berufsgruppe.toString().split('.').last.toLowerCase() == formattedBerufsgruppe.toLowerCase()) {
      //if ('berufsgruppe.$BerufsStr' == berufsgruppe.toString()) {
        return berufsgruppe;
      }
    }
    return null; // Return null or handle unexpected string case as needed
  }
  static Wohnart? parseWohnart(String? wohnartStr) {
    if (wohnartStr == null) {
      return null;
    }
    String formattedBerufsgruppe = wohnartStr.replaceAll('"', '');
    for (var wohnart in Wohnart.values) {
      if (wohnart.toString().split('.').last.toLowerCase() == formattedBerufsgruppe.toLowerCase()) {
      //if ('wohnart.$wohnartStr' == wohnart.toString()) {
        return wohnart;
      }
    }
    return null;
  }
   static Produkte? parseProdukte(String? produkteStr) {
    if (produkteStr == null) {
      return null;
    }
     String formattedProdukt = produkteStr.replaceAll('"', '');
    for (var produkte in Produkte.values) {
      if (produkte.toString().split('.').last.toLowerCase() == formattedProdukt.toLowerCase()) {
      //if ('produkte.$produkteStr' == produkte.toString()) {
        return produkte;
      }
    }
    return null;
  }
    static Kundenstatus? parseKundenstatus(String? kundenstatusStr) {
    if (kundenstatusStr == null) {
      return null;
    }
    String formattedKundenStatus = kundenstatusStr.replaceAll('"', '');
    for (var kundenstatus in Kundenstatus.values) {
      if (kundenstatus.toString().split('.').last.toLowerCase() == formattedKundenStatus.toLowerCase()) {
      //if ('kundenStatus.$kundenstatusStr' == kundenstatus.toString()) {
        return kundenstatus;
      }
    }
    return null;
  }
   static NummerTyp? parseNummerTyp(String? NummerTypStr) {
    if (NummerTypStr == null) {
      return null;
    }
    String formattedNummerTyp= NummerTypStr.replaceAll('"', '');
    for (var nummerTyp in NummerTyp.values) {
       if (nummerTyp.toString().split('.').last.toLowerCase() == formattedNummerTyp.toLowerCase()) {
      //if ('nummerTyp.$NummerTypStr' == nummerTyp.toString()) {
        return nummerTyp;
      }
    }
    return null;
  }

 factory Kunde.fromMap(Map<String, dynamic> map) {
    return Kunde(
      id: map['id'] as int,
      bezirkId: map['bezirkId'] as int ,
       filialeId: map['filialeId'] as int,
       geschlecht: parseGeschlecht(map['geschlecht'] as String?),
      //geschlecht: parseGeschlecht(map['geschlecht']),
      //map['geschlecht'] != null ? Geschlecht.values.firstWhere((e) => e.toString() == 'geschlecht.' + map['geschlecht']) : null,
      Titel: map['titel'] ?? '' ,
      Name: map['name'] ?? '' ,
      Geburtsname: map['geburtsname']?? '' ,
      Vorname: map['vorname']?? '' ,
      Strasse: map['strasse']?? '' ,
      PLZ: map['plz']?? '' ,
      Ort: map['ort']?? '' ,
      Gebursdatum:map['geburtsdatum'] != null 
                ? DateTime.tryParse(map['geburtsdatum']) ?? DateTime.now()
                : DateTime.now(),
      Land: map['land']?? '',
      Staatsangehorigkeit: map['staatsangehorigkeit']?? '',
      Email: map['email']?? '',
      familienstatus: parseFamilienstatus(map['familienstatus']as String?),
      //map['familienstatus'] != null ? Familienstatus.values.firstWhere((e) => e.toString() == 'familienstatus.' + map['familienstatus']) : null,
      berufsgruppe: parseBerufsgruppe(map['berufsgruppe']as String?),
      //map['berufsgruppe'] != null ? Berufsgruppe.values.firstWhere((e) => e.toString() == 'berufsgruppe.' + map['berufsgruppe']) : null,
      selbststandig: map['selbststandig']?? '',
      selbstandingseit: map['selbstandingseit'] != null 
                      ? DateTime.tryParse(map['selbstandingseit']) ?? DateTime.now()
                      : DateTime.now(),
      branche: map['branche']?? '',
      netto: map['netto']?? '',
      AnzahlderKinde: map['anzahlderKinde']?? '',
      wohnart: parseWohnart(map['wohnart']as String?),
      //map['wohnart'] != null ? Wohnart.values.firstWhere((e) => e.toString() == 'wohnart.' + map['wohnart']) : null,
      produkte:  parseProdukte(map['produkte']as String?),
      //map['produkte'] != null ? Produkte.values.firstWhere((e) => e.toString() == 'produkte.' + map['produkte']) : null,
      //nummern: Map.fromEntries(map['nummern'].map((entry) => MapEntry(NummerTyp.values.firstWhere((e) => e.toString() == 'nummerTyp.' + entry.key), entry.value))),
      nummerTyp: parseNummerTyp(map['nummerTyp']as String?),
      //map['nummerTyp'] != null ? NummerTyp.values.firstWhere((e) => e.toString() == 'nummerTyp.' + map['nummerTyp']) : null,
      nummer: map['nummer']?? '',
      kundenstatus: parseKundenstatus(map['kundenStatus']as String?),
      //map['kundenStatus'] != null ? Kundenstatus.values.firstWhere((e) => e.toString() == 'kundenStatus.' + map['kundenStatus']) : null,
      kundennummer: map['kundennummer']?? '',
      kontonummer: map['kontonummer']?? '',
   einverstandenWerbungPerEmail: map['einverstandenWerbungPerEmail'] ??false,
einverstandenUebermittlungAnSchufa: map['einverstandenUebermittlungAnSchufa'] ??false,
emailSentForBirthday: map['emailSentForBirthday'] ??false,
    );
  }
 
  factory Kunde.fromJson(Map<String, dynamic> json) {
 try {
      return Kunde(
        id: json['id']as int  ,
        bezirkId: json['bezirkId']as int  ,
        filialeId: json['filialeId'] as int ,
        geschlecht: parseGeschlecht(json['geschlecht'] as String?),
       // geschlecht: parseGeschlecht(json['geschlecht']),
        /*json['geschlecht'] != null
            ? Geschlecht.values.firstWhere(
                (e) => e.toString() == 'geschlecht.' + json['geschlecht'])
            : null,*/
        Titel: json['titel'] ?? '',
        Name: json['name'] ?? '',
        Geburtsname: json['geburtsname'] ?? '',
        Vorname: json['vorname'] ?? '',
        Strasse: json['strasse'] ?? '',
        PLZ: json['plz'] ?? '',
        Ort: json['ort'] ?? '',
        Gebursdatum: json['geburtsdatum'] != null 
                ? DateTime.tryParse(json['geburtsdatum']) ?? DateTime.now()
                : DateTime.now(),
        Land: json['land'] ?? '',
        Staatsangehorigkeit: json['staatsangehorigkeit'] ?? '',
        Email: json['email'] ?? '',
        familienstatus:parseFamilienstatus(json['familienstatus']as String?),
         /*json['familienstatus'] != null
            ? Familienstatus.values.firstWhere(
                (e) =>
                    e.toString() == 'familienstatus.' + json['familienstatus'])
            : null,*/
        berufsgruppe: parseBerufsgruppe(json['berufsgruppe']as String?),
        /*json['berufsgruppe'] != null
            ? Berufsgruppe.values.firstWhere(
                (e) => e.toString() == 'berufsgruppe.' + json['berufsgruppe'])
            : null,*/
        selbststandig: json['selbststandig'] ?? false,
        selbstandingseit: json['selbstandingseit'] != null 
                ? DateTime.tryParse(json['selbstandingseit']) ?? DateTime.now()
                : DateTime.now(),
        branche: json['branche'] ?? '',
        netto: json['netto'] ?? '',
        AnzahlderKinde: json['anzahlDerKinde'] ?? '',
        wohnart: parseWohnart(json['wohnart']as String?),
        /*json['wohnart'] != null
            ? Wohnart.values.firstWhere(
                (e) => e.toString() == 'wohnart.' + json['wohnart'])
            : null,*/
        produkte: parseProdukte(json['produkte']as String?),
         /*json['produkte'] != null
            ? Produkte.values.firstWhere(
                (e) => e.toString() == 'produkte.' + json['produkte'])
            : null,*/
        /*ummern: Map.fromEntries((json['nummern'] ?? {})
            .map((key, value) => MapEntry(
                NummerTyp.values.firstWhere(
                    (e) => e.toString() == 'nummerTyp.' + key),
                value))),*/
                nummerTyp:  parseNummerTyp(json['nummerTyp']as String?),
                /*json['nummerTyp'] != null
            ? NummerTyp.values.firstWhere(
                (e) => e.toString() == 'nummerTyp.' + json['nummerTyp'])
            : null,*/
            nummer: json['nummer'] ?? '',
        kundenstatus:parseKundenstatus(json['kundenStatus']as String?),
         /*json['kundenStatus'] != null
            ? Kundenstatus.values.firstWhere(
                (e) =>
                    e.toString() == 'kundenStatus.' + json['kundenStatus'])
            : null,*/
        kundennummer: json['kundennummer'] ?? '',
        kontonummer: json['kontonummer'] ?? '',
        einverstandenWerbungPerEmail: json['einverstandenWerbungPerEmail'] ?? false,
        einverstandenUebermittlungAnSchufa: json['einverstandenUebermittlungAnSchufa'] ?? false,
        emailSentForBirthday: json['emailSentForBirthday'] ??false,
        
        // ... andere Zuweisungen ...
      ); 
      }catch (e) {
    print('Fehler beim Konvertieren von JSON zu Kunde: $e');
    rethrow;
     // Oder eine Standardwerte oder Fehlerbehandlung hier einfügen
  }
}

  
  Map<String, dynamic> ToJson() {
    return {
      'id':id,
      'bezirkId' : bezirkId,
      'filialeId':filialeId,
      //'geschlecht': geschlecht?.toString(),
      'geschlecht': geschlecht?.toString().split('.').last,
      'titel': Titel,
      'name': Name,
      'geburtsname': Geburtsname,
      'vorname': Vorname,
      'strasse': Strasse,
      'plz': PLZ,
      'ort': Ort,
      'geburtsdatum': Gebursdatum.toIso8601String(),
      'land': Land,
      'staatsangehorigkeit': Staatsangehorigkeit,
      'email': Email,
      'familienstatus': familienstatus?.toString().split('.').last,
      'berufsgruppe': berufsgruppe?.toString().split('.').last,
      'selbststandig': selbststandig,
      'selbstandingseit': selbstandingseit.toIso8601String(),
      'branche': branche,
      'netto': netto,
      'anzahlderKinde': AnzahlderKinde,
      'wohnart': wohnart?.toString().split('.').last,
      'produkte': produkte?.toString().split('.').last,
      //'nummer': '0178885361', //map((key, value) => MapEntry(key.toString().split('.')[1], value)),
      'nummerTyp':nummerTyp?.toString(),
      'nummer':nummer,
      'kundenStatus': kundenstatus?.toString().split('.').last,
      'kundennummer': kundennummer,
      'kontonummer': kontonummer,
      'einverstandenWerbungPerEmail': einverstandenWerbungPerEmail,
      'einverstandenUebermittlungAnSchufa': einverstandenUebermittlungAnSchufa,
      'emailSentForBirthday': emailSentForBirthday,
    };
  }

 
}

  


