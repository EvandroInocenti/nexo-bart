import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'treatment_patient.dart';

class TreatmentPatientList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<TreatmentPatient> get items => [..._items];

  List<TreatmentPatient> _items = [];
  TreatmentPatientList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTreatmentPatient(int id) async {
    List<TreatmentPatient> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/patients/treatments/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var treatmentPatientJson = jsonDecode(response.body)["treatments"];
    if (response.statusCode == 200) {
      List<TreatmentPatient> treatmentPatient = List<TreatmentPatient>.from(
          treatmentPatientJson.map((i) => TreatmentPatient.fromJson(i)));

      for (var element in treatmentPatient) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar tratamento anterior do paciente.');
    }
  }
}
