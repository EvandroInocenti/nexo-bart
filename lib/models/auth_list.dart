import 'package:flutter/foundation.dart';
import 'package:nexo_onco/services/databaseController.dart';

import 'auth.dart';

class AuthList with ChangeNotifier {
  String token;
  // final List<Auth> _items = [];

  List<Auth> get items => [..._items];

  List<Auth> _items = [];
  AuthList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<Auth> getAuth() async {
    final db = await DatabaseController().db;
    List<Map<String, Object?>> result = await db.query(
      'auth',
    );

    List<Auth> items = [];

    List<Auth> auth = List<Auth>.from(result.map((i) => Auth.fromJson(i)));

    for (var element in auth) {
      items.add(element);
    }

    notifyListeners();

    if (auth.isEmpty) {
      return Auth();
    }
    return auth.first;
  }

  void addAuth(
      token, email, confirmed, role, idPatient, institutionId, firebaseToken) {
    final newAuth = Auth(
      token: token,
      email: email,
      confirmed: confirmed,
      role: role,
      idPatient: idPatient,
      institutionId: institutionId,
      firebaseToken: firebaseToken,
    );

    _items.add(newAuth);
  }
}
