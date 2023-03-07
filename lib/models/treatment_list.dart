import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'treatment.dart';

class TreatmentList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<Treatment> get items => [..._items];

  List<Treatment> _items = [];
  TreatmentList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTreatment() async {
    List<Treatment> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/treatments'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var patientJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Treatment> patient =
          List<Treatment>.from(patientJson.map((i) => Treatment.fromJson(i)));

      for (var element in patient) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar tratamentos.');
    }
  }
}
