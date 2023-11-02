// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_weekly_answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientWeeklyAnswers _$PatientWeeklyAnswersFromJson(
        Map<String, dynamic> json) =>
    PatientWeeklyAnswers(
      id: json['id'] as int?,
      lost_appetite: json['lost_appetite'] as bool?,
      lost_strength: json['lost_strength'] as bool?,
      difficulty_sleeping: json['difficulty_sleeping'] as bool?,
      emotional_problem: json['emotional_problem'] as bool?,
      sexual_problem: json['sexual_problem'] as bool?,
      memory_problem: json['memory_problem'] as bool?,
      concentration_problem: json['concentration_problem'] as bool?,
      patient_id: json['patient_id'] as int?,
    );

Map<String, dynamic> _$PatientWeeklyAnswersToJson(
        PatientWeeklyAnswers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lost_appetite': instance.lost_appetite,
      'lost_strength': instance.lost_strength,
      'difficulty_sleeping': instance.difficulty_sleeping,
      'emotional_problem': instance.emotional_problem,
      'sexual_problem': instance.sexual_problem,
      'memory_problem': instance.memory_problem,
      'concentration_problem': instance.concentration_problem,
      'patient_id': instance.patient_id,
    };
