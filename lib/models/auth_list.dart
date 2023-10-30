import 'package:flutter/foundation.dart';
import 'package:nexo_onco/services/databaseController.dart';

import 'auth.dart';

class AuthList with ChangeNotifier {
  final List<Auth> _items = [];

  Future<List<Auth>> getAuth() async {
    final db = await DatabaseController().db;
    List<Map<String, dynamic>> result = await db.query(
      'auth',
    );

    List<Auth> auths = [];
    for (var element in result) {
      auths.add(
        Auth(
          token: element["token"],
          email: element["email"],
          confirmed: element["confirmed"] == 1 ? true : false,
          role: element["role"],
          idPatient: element["idPatient"],
          institutionId: int.tryParse(element["institutionId"]),
          firebaseToken: element["firebaseToken"],
        ),
      );
    }

    // notifyListeners();

    print(auths.length);
    return auths;
  }

  List<Auth> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
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
