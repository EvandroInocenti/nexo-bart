import 'package:flutter/foundation.dart';
import 'package:nexo_onco/services/databaseController.dart';

import 'auth.dart';

class AuthList with ChangeNotifier {
  List<Auth> _items = [];

  // Future<void> loadAuths() async {
  //   final dataList = await DatabaseController.getData('auth');
  //   _items = dataList
  //       .map(
  //         (item) => Auth(
  //           token: item['token'],
  //           email: item['email'],
  //           confirmed: item['confirmed'],
  //           role: item['role'],
  //           idPatient: item['idPatient'],
  //           institutionId: item['institutionId'],
  //           firebaseToken: item['firebaseToken'],
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

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
    // try {
    //   DatabaseController.insert('auth', {
    //     'token': token,
    //     'email': email,
    //     'confirmed': confirmed,
    //     'role': role,
    //     'idPatient': idPatient,
    //     'institutionId': institutionId ?? '',
    //     'firebaseToken': firebaseToken,
    //   });
    //   notifyListeners();
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }

  // Future<List<Auth>> loadAuth() async {
  //   _items = await DatabaseController().getAuth();
  //   notifyListeners();
  //   return _items;
  // }

  // Future<List<Auth>> items() async {
  //   notifyListeners();

  //   return _items;
  // }
}
