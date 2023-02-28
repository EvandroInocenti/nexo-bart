import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(String email, String password) async {
    final url = Uri.parse('${dotenv.env['API_URL']!}/auth/login');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'email': email.trim(),
        'password': password.trim(),
      }),
    );
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }
}
