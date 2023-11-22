import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nexo_onco/services/databaseController.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth with ChangeNotifier {
  String? token;
  String? email;
  int? idPatient;
  String? role;
  bool? confirmed;
  int? institutionId;
  String? firebaseToken;
  String? lastAccess;

  Auth({
    this.token,
    this.email,
    this.idPatient,
    this.role,
    this.confirmed,
    this.institutionId,
    this.firebaseToken,
    this.lastAccess,
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

      // Alterar data de acesso
      lastAccess =
          DateFormat("yyyy-MM-dd").format(DateTime.parse("2023-11-13"));
      // lastAccess = DateFormat("yyyy-MM-dd").parse('2023-10-30');

      firebaseToken = await FirebaseMessaging.instance.getToken();
      await sendFirebaseToken(firebaseToken!);

      // Add DB Auth
      DatabaseController().insertAuth(token, email, confirmed, role, idPatient,
          institutionId, firebaseToken, lastAccess);

      notifyListeners();

      if (kDebugMode) {
        print('AuthToken: $token');
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

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
