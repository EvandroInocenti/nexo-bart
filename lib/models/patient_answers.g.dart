// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientAnswers _$PatientAnswersFromJson(Map<String, dynamic> json) =>
    PatientAnswers(
      id: json['id'] as int?,
      felling: json['felling'] as int?,
      temperature: json['temperature'] as int?,
      difficulty_breathing: json['difficulty_breathing'] as bool?,
      convulsion: json['convulsion'] as bool?,
      body_ache: json['body_ache'] as bool?,
      tiredness: json['tiredness'] as bool?,
      mouth_sore: json['mouth_sore'] as bool?,
      pain_when_swallowing: json['pain_when_swallowing'] as bool?,
      hot_skin: json['hot_skin'] as bool?,
      diarrhea: json['diarrhea'] as bool?,
      vomit: json['vomit'] as bool?,
      bruise: json['bruise'] as bool?,
      skin_change: json['skin_change'] as bool?,
      patient_id: json['patient_id'] as int?,
    );

Map<String, dynamic> _$PatientAnswersToJson(PatientAnswers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'felling': instance.felling,
      'temperature': instance.temperature,
      'difficulty_breathing': instance.difficulty_breathing,
      'convulsion': instance.convulsion,
      'body_ache': instance.body_ache,
      'tiredness': instance.tiredness,
      'mouth_sore': instance.mouth_sore,
      'pain_when_swallowing': instance.pain_when_swallowing,
      'hot_skin': instance.hot_skin,
      'diarrhea': instance.diarrhea,
      'vomit': instance.vomit,
      'bruise': instance.bruise,
      'skin_change': instance.skin_change,
      'patient_id': instance.patient_id,
    };
