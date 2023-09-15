import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../exceptions/http_exception.dart';
import 'auth.dart';
import 'patient_weekly_answers.dart';

class PatientWeeklyAnswersList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  final auth = Auth();

  String token;
  int idPatient;

  // Clona a lista de itens
  List<PatientWeeklyAnswers> get items => [..._items];

  List<PatientWeeklyAnswers> _items = [];
  PatientWeeklyAnswersList(
    this.token,
    this.idPatient,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> savePatientWeeklyAnswers(
      PatientWeeklyAnswers patientWeeklyAnswers) async {
    bool hasId = patientWeeklyAnswers.id != null;

    if (!hasId) {
      return addPatientWeeklyAnsware(patientWeeklyAnswers);
    }
    // else {
    //   return updateTreatmentPatient(patientAnswers);
    // }
  }

  Future<void> addPatientWeeklyAnsware(
      PatientWeeklyAnswers patientWeeklyAnswers) async {
    final response = await http.post(
      Uri.parse('$_url/patients/weekly/$idPatient'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          // "patient_id": idPatient,
          "lost_appetite": patientWeeklyAnswers.lost_appetite,
          "lost_strength": patientWeeklyAnswers.lost_strength,
          "difficulty_sleeping": patientWeeklyAnswers.difficulty_sleeping,
          "emotional_problem": patientWeeklyAnswers.emotional_problem,
          "sexual_problem": patientWeeklyAnswers.sexual_problem,
          "memory_problem": patientWeeklyAnswers.memory_problem,
          "concentration_problem": patientWeeklyAnswers.concentration_problem,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não é possível salvar resposta do paciente',
        statusCode: response.statusCode,
      );
    }

    final id = jsonDecode(response.body)['id'];
    _items.add(
      PatientWeeklyAnswers(
        id: id,
        lost_appetite: patientWeeklyAnswers.lost_appetite,
        lost_strength: patientWeeklyAnswers.lost_strength,
        difficulty_sleeping: patientWeeklyAnswers.difficulty_sleeping,
        emotional_problem: patientWeeklyAnswers.emotional_problem,
        sexual_problem: patientWeeklyAnswers.sexual_problem,
        memory_problem: patientWeeklyAnswers.sexual_problem,
        concentration_problem: patientWeeklyAnswers.concentration_problem,
        patient_id: idPatient,
      ),
    );

    // final firebaseToken = await FirebaseMessaging.instance.getToken();
    // auth.sendFirebaseToken(firebaseToken as String);

    notifyListeners();
  }
}
