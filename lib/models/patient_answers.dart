import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'patient.dart';

part 'patient_answers.g.dart';

@JsonSerializable()
class PatientAnswers with ChangeNotifier {
  int? id;
  int? felling;
  int? temperature;
  bool? difficulty_breathing;
  bool? convulsion;
  bool? body_ache;
  bool? tiredness;
  bool? mouth_sore;
  bool? pain_when_swallowing;
  bool? hot_skin;
  bool? diarrhea;
  bool? vomit;
  bool? bruise;
  bool? skin_change;
  int? patient_id;

  PatientAnswers({
    this.id,
    this.felling,
    this.temperature,
    this.difficulty_breathing,
    this.convulsion,
    this.body_ache,
    this.tiredness,
    this.mouth_sore,
    this.pain_when_swallowing,
    this.hot_skin,
    this.diarrhea,
    this.vomit,
    this.bruise,
    this.skin_change,
    this.patient_id,
  });

  factory PatientAnswers.fromJson(Map<String, dynamic> json) =>
      _$PatientAnswersFromJson(json);
  Map<String, dynamic> toJson() => _$PatientAnswersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
