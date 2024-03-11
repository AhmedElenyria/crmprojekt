
import 'package:flutter/material.dart';


enum ActivityType {
  EMAIL, 
  PHONE_CALL, 
  IN_PERSON_MEETING, 
  VIDEO_CALL, 
  Social_Media_Interactions, 
  others,
}
enum initiatorOptions{
  Kunde,
  Bank
}

class KontaktEntry {
    final int? id; 
  final String filialeName;
  final String kundeName;
  final String kundeVorname;
  ActivityType? activityType;
  final DateTime date;
  initiatorOptions? initiator;
   final String customerNeeds;
   final String angebot;
    bool acceptance;
 final  String rejectionReason;

 

  KontaktEntry({
   this.id,
    required this.filialeName,
    required this.kundeName,
    required this.kundeVorname,
    required this.activityType,
    required this.date,
    required this.initiator,
    required  this.customerNeeds,
    required this.angebot,
     required this.acceptance,
    required this.rejectionReason,


  });

  Map<String, dynamic> toJson() => {
    'id': id,
        'filialeName': filialeName,
        'kundeName': kundeName,
        'kundeVorname': kundeVorname,
        'activityType': activityType.toString().split('.').last, 
        'date': date.toIso8601String(), 
        'initiator':initiator.toString().split('.').last, 
         'customerNeeds': customerNeeds,
          'angebot': angebot,
          'acceptance': acceptance,
           'rejectionReason': rejectionReason,
           
  };
 static ActivityType? parseActivityType(String? activity) {
  if (activity == null) {
    return null;
  }
  // Ensure the string is trimmed and has no extra quotes
  String formattedActivity = activity.trim().replaceAll('"', '');
  for (var type in ActivityType.values) {
    // Using enum.toString() yields strings like 'ActivityType.EMAIL', so we split by '.' and compare the last part
    if (type.toString().split('.').last.toUpperCase() == formattedActivity.toUpperCase()) {
      return type;
    }
  }
  return null; // Or return a default value instead of null if that makes sense for your app
}
 static initiatorOptions? parseInitiator(String? initiator) {
  if (initiator == null) {
    return null;
  }
  // Ensure the string is trimmed and has no extra quotes
  String formattedinitiator = initiator.trim().replaceAll('"', '');
  for (var type in initiatorOptions.values) {

    if (type.toString().split('.').last.toUpperCase() == formattedinitiator.toUpperCase()) {
      return type;
    }
  }
  return null; // Or return a default value instead of null if that makes sense for your app
}
 factory KontaktEntry.fromJson(Map<String, dynamic> json) {
  return KontaktEntry(
    id: json['id'],
    filialeName: json['filialeName']as String? ?? "",
    kundeName: json['kundeName']as String? ?? "",
    kundeVorname: json['kundeVorname']as String? ?? "",
    date: DateTime.parse(json['date']),
    activityType: parseActivityType(json['activityType'] as String?),
    initiator: parseInitiator(json['initiator'] as String?),
    customerNeeds: json['customerNeeds']as String? ?? "",
    angebot: json['angebot']as String? ?? "",
         acceptance: json['acceptance'],
          rejectionReason: json['rejectionReason']as String? ?? "",
          
         
  );
}
String getActivityTypeString(ActivityType type) {
  switch (type) {
    case ActivityType.EMAIL:
      return 'Email';
    case ActivityType.PHONE_CALL:
      return 'Phone Call';
    case ActivityType.IN_PERSON_MEETING:
      return 'In Person';
    case ActivityType.VIDEO_CALL:
      return 'Video Call';
    case ActivityType.Social_Media_Interactions:
      return 'Social Media Interactions';
    case ActivityType.others:
      return 'Others';
    default:
      return '';
  
}

}
String getinitiatorString(initiatorOptions type) {
  switch (type) {
    case initiatorOptions.Kunde:
      return 'Kunde';
    case initiatorOptions.Bank:
      return 'Bank';
    default:
      return '';
  
}
}
}