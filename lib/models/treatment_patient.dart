import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'treatment.dart';

part 'treatment_patient.g.dart';

@JsonSerializable()
class TreatmentPatient with ChangeNotifier {
  int? id;
  int? patientId;
  int? treatmentId;
  int? cicloId;
  String? startDate;
  String? dose;
  String? doseTotal;
  Treatment? treatment;

  TreatmentPatient({
    this.id,
    this.patientId,
    this.treatmentId,
    this.cicloId,
    this.startDate,
    this.dose,
    this.doseTotal,
    this.treatment,
  });

  factory TreatmentPatient.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPatientFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentPatientToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
