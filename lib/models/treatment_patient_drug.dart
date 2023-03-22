import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment_patient_drug.g.dart';

@JsonSerializable()
class TreatmentPatientDrug with ChangeNotifier {
  int? id;
  int? treatment_patient_id;
  int? drug_id;

  TreatmentPatientDrug({
    this.id,
    this.treatment_patient_id,
    this.drug_id,
  });

  factory TreatmentPatientDrug.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPatientDrugFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentPatientDrugToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
