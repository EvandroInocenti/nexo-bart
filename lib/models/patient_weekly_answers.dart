import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_weekly_answers.g.dart';

@JsonSerializable()
class PatientWeeklyAnswers with ChangeNotifier {
  int? id;
  bool? lost_appetite;
  bool? lost_strength;
  bool? difficulty_sleeping;
  bool? emotional_problem;
  bool? sexual_problem;
  bool? memory_problem;
  bool? concentration_problem;
  int? patient_id;

  PatientWeeklyAnswers({
    this.id,
    this.lost_appetite,
    this.lost_strength,
    this.difficulty_sleeping,
    this.emotional_problem,
    this.sexual_problem,
    this.memory_problem,
    this.concentration_problem,
    this.patient_id,
  });

  factory PatientWeeklyAnswers.fromJson(Map<String, dynamic> json) =>
      _$PatientWeeklyAnswersFromJson(json);
  Map<String, dynamic> toJson() => _$PatientWeeklyAnswersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
