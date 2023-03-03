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
      difficultyBreathing: json['difficultyBreathing'] as bool?,
      convulsion: json['convulsion'] as bool?,
      bodyAche: json['bodyAche'] as bool?,
      tiredness: json['tiredness'] as bool?,
      mouthSore: json['mouthSore'] as bool?,
      painWhenSwallowing: json['painWhenSwallowing'] as bool?,
      hotSkin: json['hotSkin'] as bool?,
      diarrhea: json['diarrhea'] as bool?,
      vomit: json['vomit'] as bool?,
      bruise: json['bruise'] as bool?,
      skinChange: json['skinChange'] as bool?,
      patient: json['patient'] == null
          ? null
          : Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientAnswersToJson(PatientAnswers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'felling': instance.felling,
      'temperature': instance.temperature,
      'difficultyBreathing': instance.difficultyBreathing,
      'convulsion': instance.convulsion,
      'bodyAche': instance.bodyAche,
      'tiredness': instance.tiredness,
      'mouthSore': instance.mouthSore,
      'painWhenSwallowing': instance.painWhenSwallowing,
      'hotSkin': instance.hotSkin,
      'diarrhea': instance.diarrhea,
      'vomit': instance.vomit,
      'bruise': instance.bruise,
      'skinChange': instance.skinChange,
      'patient': instance.patient,
    };
