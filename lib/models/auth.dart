import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  int? _idPatient;
  String? _role;
  bool? _confirmed;
  int? _institutionId;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  int? get idPatient {
    return isAuth ? _idPatient : null;
  }

  String? get role {
    return isAuth ? _role : null;
  }

  bool? get confirmed {
    return isAuth ? _confirmed : null;
  }

  int? get institutionId {
    return isAuth ? _institutionId : null;
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
      _token = body['authToken']['token'];
      _role = body['user']['role'];
      if (_role == "P") {
        _idPatient = body['user']['patient']['id'];
      }
      _email = body['user']['email'];
      _confirmed = body['user']['confirmed'];
      _institutionId = body['user']['institution_id'];

      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  void logout() {
    _token = null;
    _email = null;
    _idPatient = null;
    _role = null;
    _confirmed = null;
    _institutionId = null;
    notifyListeners();
  }
}
