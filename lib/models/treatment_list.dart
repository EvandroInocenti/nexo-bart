import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  Treatment getTreatment(int id) {
    var treatment = [..._items].singleWhere((el) => el.id == id);

    if (kDebugMode) {
      print(treatment);
    }
    return treatment;
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

    var treatmentJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Treatment> treatment =
          List<Treatment>.from(treatmentJson.map((i) => Treatment.fromJson(i)));

      for (var element in treatment) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar tratamentos.');
    }
  }
}
