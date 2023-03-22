import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'treatment.dart';

part 'treatment_patient.g.dart';

@JsonSerializable()
class TreatmentPatient with ChangeNotifier {
  int? id;
  int? patient_id;
  int? treatment_id;
  int? ciclo_id;
  String? start_date;
  String? dose;
  String? dose_total;
  Treatment? treatment;

  TreatmentPatient({
    this.id,
    this.patient_id,
    this.treatment_id,
    this.ciclo_id,
    this.start_date,
    this.dose,
    this.dose_total,
    this.treatment,
  });

  String getformatDate(String _startDate) {
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(_startDate);
    String dateFormat = DateFormat('dd/MM/yyyy').format(parseDate);
    return dateFormat;
  }

  factory TreatmentPatient.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPatientFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentPatientToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
