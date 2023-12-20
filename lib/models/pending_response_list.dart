import 'package:flutter/foundation.dart';
import 'package:nexo_onco/services/databaseController.dart';

import 'pending_response.dart';

class PendingResponseList with ChangeNotifier {
  List<PendingResponse> get items => [..._items];

  List<PendingResponse> _items = [];

  int get itemsCount {
    return _items.length;
  }

  Future<void> remove(int i) async {
    DatabaseController().deletePendingResponse(i);
    if (kDebugMode) {
      print("Resposta pendente removida: $i");
    }

    notifyListeners();
  }

  Future<PendingResponse> getPendingResponse() async {
    final db = await DatabaseController().db;
    List<Map<String, Object?>> result = await db.query(
      'pending_response',
    );

    List<PendingResponse> items = [];

    List<PendingResponse> response = List<PendingResponse>.from(
        result.map((i) => PendingResponse.fromJson(i)));

    for (var element in response) {
      items.add(element);
    }

    _items = items.toList();
    notifyListeners();

    if (response.isEmpty) {
      return PendingResponse();
    }
    return response.first;
  }

  void addPendingResponse(title, date, period) {
    final newResponse = PendingResponse(
      title: title,
      date: date,
      period: period,
    );

    items.add(newResponse);

    DatabaseController().insertPendingResponse(
      title,
      date,
      period,
    );

    print(items);

    notifyListeners();
  }

  void removePendingResponse(id) {
    items.remove(id);
    DatabaseController().deletePendingResponse(id);
  }
}
