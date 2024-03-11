/*
import 'dart:convert';

KundenModel kundenModelJson(String str)=>
KundenModel.fromJson(json.decode(str  ));

String KundenModelToJSon(KundenModel data) =>json.encode(data.ToJson());


class KundenModel {
  String Name;
  String Vorname;
  DateTime Gebursdatum;
   String Staatsangehorigkeit;

   KundenModel({required this.Name,required this.Vorname,required this.Gebursdatum,required this.Staatsangehorigkeit});

   factory KundenModel.fromJson(Map<String,dynamic>  json)=> KundenModel(
    Name: json["Name"],
    Vorname: json["Vorname"],
    Gebursdatum: json["Gebursdatum"],
  Staatsangehorigkeit: json["Staatsangehorigkeit"]
   );
   Map<String,dynamic> ToJson() =>{
    "Name":Name,
    "Vorname":Vorname,
    "Gebursdatum":Gebursdatum,
    "Staatsangehorigkeit":Staatsangehorigkeit,
   };

   String get name=> Name;

   String get vorname => Vorname;


}*/