import 'dart:math';
import 'Filiale.dart';
import 'Bezirk.dart';

class KundennummerService {
  String generateKundennummer(Filiale filiale) {
    String kundennummer = _generateRandomNumber().toString();
    int pruefziffer = _calculatePruefziffer(kundennummer);
    String bezirkCode = _getBezirkCode(filiale.bezirk);
    String filialeCode = _getFilialeCode(filiale);

    return '$bezirkCode$filialeCode$kundennummer$pruefziffer';
  }

  int _generateRandomNumber() {
    return Random().nextInt(100000);
  }

  int _calculatePruefziffer(String kundennummer) {
    int summe = 0;
    for (int i = 0; i < kundennummer.length; i++) {
      summe += int.parse(kundennummer[i]);
    }
    return summe % 11;
  }

  String _getBezirkCode(Bezirk bezirk) {
    // Hier kannst du die Zuordnung der Bezirkscodes implementieren
    // Zum Beispiel: Bezirk Mitte ist 30
    if (bezirk.name == 'Bezirk Mitte') {
      return '30';
    }
    
    return '00'; // Standardcode, falls Bezirk nicht erkannt wird
  }

  String _getFilialeCode(Filiale filiale) {
    // Hier kannst du die Zuordnung der Filialcodes implementieren
    // Zum Beispiel: Filiale Darmstadt ist 10
    if (filiale.name == 'Filiale Darmstadt') {
      return '10';
    } else if (filiale.name == 'Filiale Frankfurt') {
      return '20';
    } else if (filiale.name == 'Filiale Mainz') {
      return '30';
    } else if (filiale.name == 'Filiale Wiesbaden') {
      return '40';
    }

    return '00'; // Standardcode, falls Filiale nicht erkannt wird
  }
}
