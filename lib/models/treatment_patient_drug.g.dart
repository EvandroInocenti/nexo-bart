// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_patient_drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentPatientDrug _$TreatmentPatientDrugFromJson(Map json) =>
    TreatmentPatientDrug(
      id: json['id'] as int?,
      treatment_patient_id: json['treatment_patient_id'] as int?,
      drug_id: json['drug_id'] as int?,
    );

Map<String, dynamic> _$TreatmentPatientDrugToJson(
        TreatmentPatientDrug instance) =>
    <String, dynamic>{
      'id': instance.id,
      'treatment_patient_id': instance.treatment_patient_id,
      'drug_id': instance.drug_id,
    };
