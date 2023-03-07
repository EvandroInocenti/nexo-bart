import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'drug.dart';
import 'treatment.dart';

class DrugList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<Drug> get items => [..._items];

  List<Drug> _items = [];
  DrugList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadDrugs() async {
    List<Drug> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/drugs'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var drugJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Drug> drug = List<Drug>.from(drugJson.map((i) => Drug.fromJson(i)));

      for (var element in drug) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar o quimioterápico.');
    }
  }
}
