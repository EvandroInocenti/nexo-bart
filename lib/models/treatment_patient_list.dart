import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../exceptions/http_exception.dart';
import 'treatment_patient.dart';

class TreatmentPatientList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<TreatmentPatient> get items => [..._items];

  List<TreatmentPatient> _items = [];
  TreatmentPatientList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadTreatmentPatient(int id) async {
    List<TreatmentPatient> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/patients/treatments/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var treatmentPatientJson = jsonDecode(response.body)["treatments"];
    if (response.statusCode == 200) {
      List<TreatmentPatient> treatmentPatient = List<TreatmentPatient>.from(
          treatmentPatientJson.map((i) => TreatmentPatient.fromJson(i)));

      for (var element in treatmentPatient) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar tratamento anterior do paciente.');
    }
  }

  Future<void> saveTreatmentPatient(TreatmentPatient treatmentPatient) {
    bool hasId = treatmentPatient.id != null;

    if (hasId) {
      return updateTreatmentPatient(treatmentPatient);
    } else {
      return addTreatmentPatient(treatmentPatient);
    }
  }

  Future<void> addTreatmentPatient(TreatmentPatient treatmentPatient) async {
    final response = await http.post(
      Uri.parse('$_url/patients/treatments/${treatmentPatient.patient_id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "id": treatmentPatient.id,
          "cicle_id": treatmentPatient.ciclo_id,
          "dose": treatmentPatient.dose,
          "dose_total": treatmentPatient.dose_total,
          "patient_id": treatmentPatient.patient_id,
          "start_date": treatmentPatient.start_date,
          "treatment_id": treatmentPatient.treatment_id,
          "cicle": treatmentPatient.cicle,
          "drug": treatmentPatient.drug,
          "drugs": treatmentPatient.drugs,
          "treatment": treatmentPatient.treatment,
        },
      ),
    );

    final id = jsonDecode(response.body)['id'];
    _items.add(
      TreatmentPatient(
        id: id,
        treatment: treatmentPatient.treatment,
        drug: treatmentPatient.drug,
        drugs: treatmentPatient.drugs,
        start_date: treatmentPatient.start_date,
        dose: treatmentPatient.dose,
        ciclo_id: treatmentPatient.ciclo_id,
        dose_total: treatmentPatient.dose_total,
      ),
    );

    notifyListeners();
  }

  Future<void> updateTreatmentPatient(TreatmentPatient treatmentPatient) async {
    final response = await http.put(
      Uri.parse(
          '${_url!}/patients/treatments/${treatmentPatient.patient_id}/${treatmentPatient.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(treatmentPatient),
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não é possível salvar o tratamento do paciente',
        statusCode: response.statusCode,
      );
    }
    notifyListeners();
  }
}
