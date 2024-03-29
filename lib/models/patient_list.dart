import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:nexo_onco/exceptions/http_exception.dart';
import 'patient.dart';

import 'user.dart';

class PatientList with ChangeNotifier {
  final _url = dotenv.env['API_URL'];
  String token;

  // Clona a lista de itens
  List<Patient> get items => [..._items];

  List<Patient> get activePatients =>
      _items.where((pat) => pat.user!.confirmed!).toList();

  List<Patient> _items = [];
  PatientList(
    this.token,
    this._items,
  );

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadPatients() async {
    List<Patient> items = [];
    final response = await http.get(
      Uri.parse('${_url!}/patients'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var patientJson = jsonDecode(response.body)["data"];
    if (response.statusCode == 200) {
      List<Patient> patient =
          List<Patient>.from(patientJson.map((i) => Patient.fromJson(i)));

      for (var element in patient) {
        items.add(element);
      }

      _items = items.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Falha ao carregar pacientes');
    }
  }

  Future<void> savePatient(Patient patient) {
    // ignore: unnecessary_null_comparison
    bool hasId = patient.id != null;

    if (hasId) {
      return updatePatient(patient);
    } else {
      return addPatient(patient);
    }
  }

  Future<void> addPatient(Patient patient) async {
    final response = await http.post(
      Uri.parse('$_url/patients'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "name": patient.user!.name,
          "birthDate": patient.data_nascimento,
          "height": patient.altura,
          "weight": patient.peso,
          "bodySurface": patient.superficie_corporea,
          "tumor_id": patient.tumor_id,
          "confirmed": patient.user!.confirmed,
          "surgery": patient.surgery,
          "surgery_pain": patient.surgery_pain,
          "surgery_swollen": patient.surgery_swollen,
          "surgery_hot": patient.surgery_hot,
          "surgery_liquid": patient.surgery_liquid,
          "catheter_pain": patient.catheter_pain,
          "catheter_swollen": patient.catheter_swollen,
          "catheter_hot": patient.catheter_hot,
          "catheter_liquid": patient.catheter_liquid,
          "staging": patient.staging,
        },
      ),
    );

    final id = jsonDecode(response.body)['id'];
    _items.add(
      Patient(
        id: id,
        user: patient.user!.name as User,
        data_nascimento: patient.data_nascimento,
        altura: patient.altura,
        peso: patient.peso,
        superficie_corporea: patient.superficie_corporea,
        tumor_id: patient.tumor_id,
      ),
    );

    notifyListeners();
  }

  Future<void> updatePatient(Patient patient) async {
    int index = _items.indexWhere((p) => p.id == patient.id);

    if (index >= 0) {
      _items[index] = patient;

      final response = await http.put(
        Uri.parse('${_url!}/patients/${patient.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(patient),
      );

      if (response.statusCode >= 400) {
        throw HttpException(
          msg: 'Não é possível salvar o paciente',
          statusCode: response.statusCode,
        );
      }
      notifyListeners();
    }
  }

  Future<void> confirmPatient(int id) async {
    final response = await http.patch(
      Uri.parse('${_url!}/patients/confirm/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode >= 400) {
      throw HttpException(
        msg: 'Não foi possível liberar paciente.',
        statusCode: response.statusCode,
      );
    }
    notifyListeners();
  }

  Future<void> removePatient(Patient patient) async {
    int index = _items.indexWhere((p) => p.id == patient.id);

    if (index >= 0) {
      final patient = _items[index];
      _items.remove(patient);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${_url!}/patients/${patient.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode >= 400) {
        _items.insert(index, patient);
        notifyListeners();
        throw HttpException(
          msg: 'Não é possível excluir o paciente.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
