// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentPatient _$TreatmentPatientFromJson(Map<String, dynamic> json) =>
    TreatmentPatient(
      id: json['id'] as int?,
      patient_id: json['patient_id'] as int?,
      treatment_id: json['treatment_id'] as int?,
      ciclo_id: json['ciclo_id'] as int?,
      start_date: json['start_date'] as String?,
      dose: json['dose'] as String?,
      dose_total: json['dose_total'] as String?,
      treatment: json['treatment'] == null
          ? null
          : Treatment.fromJson(json['treatment'] as Map<String, dynamic>),
      cicle: json['cicle'] == null
          ? null
          : Cicle.fromJson(json['cicle'] as Map<String, dynamic>),
      drug: json['drug'] == null
          ? null
          : Drugs.fromJson(json['drug'] as Map<String, dynamic>),
      drugs: json['drugs'] as List<dynamic>?,
    );

Map<String, dynamic> _$TreatmentPatientToJson(TreatmentPatient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'treatment_id': instance.treatment_id,
      'ciclo_id': instance.ciclo_id,
      'start_date': instance.start_date,
      'dose': instance.dose,
      'dose_total': instance.dose_total,
      'treatment': instance.treatment,
      'cicle': instance.cicle,
      'drug': instance.drug,
      'drugs': instance.drugs,
    };
