
import 'Kunde.dart';
class KundeWithEmailStatus {
  Kunde kunde;
  bool emailSent;

  KundeWithEmailStatus({required this.kunde, this.emailSent = false});
}
