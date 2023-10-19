import 'package:flutter/foundation.dart';
import 'package:nexo_onco/services/databaseController.dart';

import 'auth.dart';

class AuthList with ChangeNotifier {
  List<Auth> _items = [];
  Future<int> itemsCount() async {
    await loadAuth();
    notifyListeners();
    return _items.length;
  }

  Future<List<Auth>> loadAuth() async {
    _items = await DatabaseController().getAuth();
    notifyListeners();
    return _items;
  }

  Future<List<Auth>> items() async {
    notifyListeners();

    return _items;
  }
}
