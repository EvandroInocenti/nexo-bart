import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'tumor.dart';

class TumorList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;
  String _selectedItem;

  List<Tumor> _items = [];
  TumorList(this.token, this._items, this._selectedItem);

  // Clona a lista de itens
  List<Tumor> get items => [..._items];

  List<Tumor> get tumors => _items.where((tumor) => tumor.id != null).toList();

  String get selected => _selectedItem;

  void setSelectedItem(String s) {
    _selectedItem = s;
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTumors() async {
    List<Tumor> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/tumors'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var tumorJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Tumor> tumor =
          List<Tumor>.from(tumorJson.map((i) => Tumor.fromJson(i)));

      print(tumor);

      for (var element in tumor) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar tumor');
    }
  }
}
