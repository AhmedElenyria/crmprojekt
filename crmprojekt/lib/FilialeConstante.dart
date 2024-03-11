import "package:crmprojekt/Bezirk.dart";
import "package:crmprojekt/Filiale.dart";
import 'package:flutter/material.dart';




class FilialeConstants {
  static const int darmstadtId = 10;
  static const int frankfurtId = 20;
  static const int mainzId = 30;
  static const int wiesbadenId = 40;
}

var darmstadtFiliale = Filiale(id: FilialeConstants.darmstadtId, name: "Darmstadt", bezirk: Bezirk.mitte, kunden: []);
var frankfurtFiliale = Filiale(id: FilialeConstants.frankfurtId, name: "Frankfurt", bezirk: Bezirk.mitte, kunden: []);
var mainzFiliale = Filiale(id: FilialeConstants.mainzId, name: "Mainz", bezirk: Bezirk.mitte, kunden: []);
var wiesbadenFiliale = Filiale(id: FilialeConstants.wiesbadenId, name: "Wiesbaden", bezirk: Bezirk.mitte, kunden: []);