import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'cicle.dart';

class CicleList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<Cicle> get items => [..._items];

  List<Cicle> _items = [];
  CicleList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  //retorna uma lista de elemento Cicle
  Cicle getCicle(int idCicle) {
    var cicle = [..._items].singleWhere((el) => el.id == idCicle);

    if (kDebugMode) {
      print(cicle);
    }
    return cicle;
  }

  Future<void> loadCicles() async {
    List<Cicle> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/cicles'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var cicleJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Cicle> cicle =
          List<Cicle>.from(cicleJson.map((i) => Cicle.fromJson(i)));

      for (var element in cicle) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar o ciclo.');
    }
  }
}
