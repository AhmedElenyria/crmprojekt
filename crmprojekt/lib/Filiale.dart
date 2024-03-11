import 'package:flutter/material.dart';
import 'Bezirk.dart';
import 'KundenBetreuerDashboardScreen.dart';
import 'Kunde.dart';
class Filiale {
  final int id;
  final String name;
  final Bezirk bezirk;
  final List<Kunde> kunden;

  Filiale({
    required this.id, 
    required this.name, 
    required this.bezirk, 
    this.kunden = const [],
  });
  /*factory Filiale.fromJson(Map<String, dynamic> json) {
  return Filiale(
    id: json['id'],
    name: json['name'],
    bezirk: Bezirk.mitte, // Default to Bezirk Mitte, or fetch this dynamically if your JSON includes this information
    kunden: [], // Initialize with an empty list, or parse this from JSON if your API provides it
  );
} */
  factory Filiale.fromJson(Map<String, dynamic> json) {
    // Assuming 'bezirk' is a nested object in your JSON
    var bezirkFromJson = Bezirk.fromJson(json['bezirk']);

    // Assuming 'kunden' is an array of objects in your JSON
    List<Kunde> kundenFromJson = [];
    if (json['kunden'] != null) {
      kundenFromJson = List<Kunde>.from(json['kunden'].map((model) => Kunde.fromJson(model)));
    }

    return Filiale(
      id: json['id'],
      name: json['name'],
      bezirk: bezirkFromJson,
      kunden: kundenFromJson,
    );
  }
}
