// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentPatient _$TreatmentPatientFromJson(Map<String, dynamic> json) =>
    TreatmentPatient(
      id: json['id'] as int?,
      patientId: json['patientId'] as int?,
      treatmentId: json['treatmentId'] as int?,
      cicloId: json['cicloId'] as int?,
      startDate: json['startDate'] as String?,
      dose: json['dose'] as String?,
      doseTotal: json['doseTotal'] as String?,
      treatment: json['treatment'] == null
          ? null
          : Treatment.fromJson(json['treatment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TreatmentPatientToJson(TreatmentPatient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'treatmentId': instance.treatmentId,
      'cicloId': instance.cicloId,
      'startDate': instance.startDate,
      'dose': instance.dose,
      'doseTotal': instance.doseTotal,
      'treatment': instance.treatment,
    };
