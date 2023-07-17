import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../exceptions/http_exception.dart';
import 'auth.dart';
import 'patient_answers.dart';

class PatientAnswersList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  final auth = Auth();

  String token;
  int idPatient;

  // Clona a lista de itens
  List<PatientAnswers> get items => [..._items];

  List<PatientAnswers> _items = [];
  PatientAnswersList(
    this.token,
    this.idPatient,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> savePatientAnswers(PatientAnswers patientAnswers) async {
    bool hasId = patientAnswers.id != null;

    if (!hasId) {
      return addPatientAnsware(patientAnswers);
    }
    // else {
    //   return updateTreatmentPatient(patientAnswers);
    // }
  }

  Future<void> addPatientAnsware(PatientAnswers patientAnswers) async {
    final response = await http.post(
      Uri.parse('$_url/patients/answers/$idPatient'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "patient_id": idPatient,
          "felling": patientAnswers.felling,
          "temperature": patientAnswers.temperature,
          "difficulty_breathing": patientAnswers.difficulty_breathing,
          "convulsion": patientAnswers.convulsion,
          "body_ache": patientAnswers.body_ache,
          "tiredness": patientAnswers.tiredness,
          "mouth_sore": patientAnswers.mouth_sore,
          "pain_when_swallowing": patientAnswers.pain_when_swallowing,
          "hot_skin": patientAnswers.hot_skin,
          "diarrhea": patientAnswers.diarrhea,
          "vomit": patientAnswers.vomit,
          "bruise": patientAnswers.bruise,
          "skin_change": patientAnswers.skin_change,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não é possível salvar o tratamento do paciente',
        statusCode: response.statusCode,
      );
    }

    final id = jsonDecode(response.body)['id'];
    _items.add(
      PatientAnswers(
        id: id,
        felling: patientAnswers.felling,
        temperature: patientAnswers.temperature,
        difficulty_breathing: patientAnswers.difficulty_breathing,
        convulsion: patientAnswers.convulsion,
        body_ache: patientAnswers.body_ache,
        tiredness: patientAnswers.tiredness,
        mouth_sore: patientAnswers.mouth_sore,
        pain_when_swallowing: patientAnswers.pain_when_swallowing,
        hot_skin: patientAnswers.hot_skin,
        diarrhea: patientAnswers.diarrhea,
        vomit: patientAnswers.vomit,
        bruise: patientAnswers.bruise,
        skin_change: patientAnswers.skin_change,
        patient_id: idPatient,
      ),
    );

    // final firebaseToken = await FirebaseMessaging.instance.getToken();
    // auth.sendFirebaseToken(firebaseToken as String);

    notifyListeners();
  }
}
