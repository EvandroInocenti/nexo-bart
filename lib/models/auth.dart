import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nexo_onco/services/databaseController.dart';

class Auth with ChangeNotifier {
  String? token;
  String? email;
  int? idPatient;
  String? role;
  bool? confirmed;
  int? institutionId;
  String? firebaseToken;

  List<Auth> _items = [];
  Future<int> itemsCount() async {
    await fetchAuths();
    notifyListeners();
    return _items.length;
  }

  Future<List<Auth>> fetchAuths() async {
    _items = await DatabaseController().getAuth();
    notifyListeners();
    return _items;
  }

  Future<List<Auth>> items() async {
    notifyListeners();

    return _items;
  }

  Auth({
    this.token,
    this.email,
    this.idPatient,
    this.role,
    this.confirmed,
    this.institutionId,
    this.firebaseToken,
  });

  bool get isAuth {
    // buscar token existente no DB

    return token != null;
  }

  String? get authToken {
    return isAuth ? token : null;
  }

  String? get authEmail {
    return isAuth ? email : null;
  }

  int? get authIdPatient {
    return isAuth ? idPatient : null;
  }

  String? get authRole {
    return isAuth ? role : null;
  }

  bool? get authConfirmed {
    return isAuth ? confirmed : null;
  }

  int? get authInstitutionId {
    return isAuth ? institutionId : null;
  }

  String? get authFirebaseToken {
    return isAuth ? firebaseToken : null;
  }

  Future<void> _authenticate(String email, String password) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      token = body['authToken']['token'];
      role = body['user']['role'];
      if (role == "P") {
        idPatient = body['user']['patient']['id'];
      }
      email = body['user']['email'];
      confirmed = body['user']['confirmed'];
      institutionId = body['user']['institution_id'];

      firebaseToken = await FirebaseMessaging.instance.getToken();
      await sendFirebaseToken(firebaseToken!);

      // Add Ab Auth
      DatabaseController().insertAuth(token, email, confirmed, role, idPatient,
          institutionId, firebaseToken);

      notifyListeners();

      if (kDebugMode) {
        print('AuthToken: ${token}');
      }
    }
  }

  Future<void> sendFirebaseToken(String fcmToken) async {
    final url =
        Uri.parse('${dotenv.env['API_URL']}/users/refresh-notification-token');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"notificationToken": fcmToken}),
    );
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> logout() async {
    final url = Uri.parse('${dotenv.env['API_URL']}/auth/logout');
    await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    // _token = null;
    // email = null;
    // idPatient = null;
    // role = null;
    // confirmed = null;
    // institutionId = null;
    notifyListeners();
  }
}
