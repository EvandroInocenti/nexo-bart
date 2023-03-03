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
  bool? difficultyBreathing;
  bool? convulsion;
  bool? bodyAche;
  bool? tiredness;
  bool? mouthSore;
  bool? painWhenSwallowing;
  bool? hotSkin;
  bool? diarrhea;
  bool? vomit;
  bool? bruise;
  bool? skinChange;
  Patient? patient;

  PatientAnswers({
    this.id,
    this.felling,
    this.temperature,
    this.difficultyBreathing,
    this.convulsion,
    this.bodyAche,
    this.tiredness,
    this.mouthSore,
    this.painWhenSwallowing,
    this.hotSkin,
    this.diarrhea,
    this.vomit,
    this.bruise,
    this.skinChange,
    this.patient,
  });

  factory PatientAnswers.fromJson(Map<String, dynamic> json) =>
      _$PatientAnswersFromJson(json);
  Map<String, dynamic> toJson() => _$PatientAnswersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
