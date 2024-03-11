import 'package:flutter/material.dart';



class EmailSend{
    final int? id; 
  final String kundeName;
  final String kundeVorname;
  final String email;
  final String betreff;
  
   final String inhalt;

   EmailSend({
    this.id,
    required this.kundeName,
    required this.kundeVorname,
    required this.email,
    required this.betreff,
    required this.inhalt,
    
     });

       Map<String, dynamic> toJson() => {
    'id': id,
        'kundeName': kundeName,
        'kundeVorname': kundeVorname, 
         'email': email,
          'betreff': betreff,
           'inhalt': inhalt,
           
  };
  factory EmailSend.fromJson(Map<String, dynamic> json) {
  return EmailSend(
    id: json['id'],
    kundeName: json['kundeName'] ?? "",
    kundeVorname: json['kundeVorname']?? "",
    email: json['email'] ?? "",
    betreff: json['betreff'] ?? "",
         inhalt: json['inhalt'] ?? "",
       
          
         
  );
}




}