import 'package:crmprojekt/FilialeConstante.dart';

import'Filiale.dart';

class Bezirk {
  int id;
  final String name;
  final List<Filiale> filialen;
  Bezirk({required this.id, required this.name, required this.filialen});
    static final Bezirk mitte = Bezirk(
    id: 30, 
    name: 'Bezirk Mitte', 
    filialen: [darmstadtFiliale, frankfurtFiliale, mainzFiliale, wiesbadenFiliale],

    
  );
    factory Bezirk.fromJson(Map<String, dynamic> json) {
  return Bezirk(
    id: json['id'],
    name: json['name'],
    filialen: [], // Initialize with an empty list, or parse this from JSON if your API provides it
  );
} 
}
