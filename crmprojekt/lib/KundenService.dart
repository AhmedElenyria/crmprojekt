import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Kunde.dart'; // Update this import based on your project structure
import 'Filiale.dart';
import 'Bezirk.dart';




class KundenService {
  final String baseUrl = 'http://localhost:8080/kunde';

  
  Future<List<Filiale>> fetchFilialen() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/filialen'));

    if (response.statusCode == 200) {
      List<dynamic> filialenJson = json.decode(response.body);
      return filialenJson.map((json) => Filiale.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load filialen');
    }
  }
  Future<List<Bezirk>> fetchBezirk() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/bezirk'));

    if (response.statusCode == 200) {
      List<dynamic> bezirkJson = json.decode(response.body);
      return bezirkJson.map((json) => Bezirk.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bezirk');
    }
  }

  Future<List<Kunde>> fetchKunden(int filialeId,int bezirkId) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookie = prefs.getString('session_cookie');
    final response = await http.get(Uri.parse('$baseUrl/filiale/$filialeId'),
    headers: cookie != null ? {'Cookie': cookie} : {},
    );
     print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> kundenJson = json.decode(response.body);
      print('Decoded JSON: $kundenJson');


      return kundenJson.map((json) => Kunde.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load customers for filiale $filialeId');
    }
  }


  Future<void> addKunde(Kunde neuerKunde) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cookie = prefs.getString('session_cookie');
    final response = await http.post(
      Uri.parse('http://localhost:8080/kunde/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        if (cookie != null) 'Cookie': cookie,
      },
      body: jsonEncode(neuerKunde.toMap()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add customer');
    }
  }
   




}



