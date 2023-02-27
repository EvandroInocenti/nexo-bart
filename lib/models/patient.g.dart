// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: json['id'] as int,
      data_nascimento: json['data_nascimento'] as String,
      altura: json['altura'] as int,
      peso: json['peso'] as int,
      superficie_corporea: (json['superficie_corporea'] as num).toDouble(),
      user_id: json['user_id'] as int?,
      doctor_id: json['doctor_id'] as int?,
      tumor_id: json['tumor_id'] as int?,
      surgery: json['surgery'] as bool? ?? false,
      surgery_pain: json['surgery_pain'] as bool? ?? false,
      surgery_swollen: json['surgery_swollen'] as bool? ?? false,
      surgery_hot: json['surgery_hot'] as bool? ?? false,
      surgery_liquid: json['surgery_liquid'] as bool? ?? false,
      catheter: json['catheter'] as bool? ?? false,
      catheter_pain: json['catheter_pain'] as bool? ?? false,
      catheter_swollen: json['catheter_swollen'] as bool? ?? false,
      catheter_hot: json['catheter_hot'] as bool? ?? false,
      catheter_liquid: json['catheter_liquid'] as bool? ?? false,
      staging: json['staging'] as int? ?? 1,
      doctor: json['doctor'] == null
          ? null
          : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      tumor: json['tumor'] == null
          ? null
          : Tumor.fromJson(json['tumor'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'data_nascimento': instance.data_nascimento,
      'altura': instance.altura,
      'peso': instance.peso,
      'superficie_corporea': instance.superficie_corporea,
      'user_id': instance.user_id,
      'doctor_id': instance.doctor_id,
      'tumor_id': instance.tumor_id,
      'surgery': instance.surgery,
      'surgery_pain': instance.surgery_pain,
      'surgery_swollen': instance.surgery_swollen,
      'surgery_hot': instance.surgery_hot,
      'surgery_liquid': instance.surgery_liquid,
      'catheter': instance.catheter,
      'catheter_pain': instance.catheter_pain,
      'catheter_swollen': instance.catheter_swollen,
      'catheter_hot': instance.catheter_hot,
      'catheter_liquid': instance.catheter_liquid,
      'staging': instance.staging,
      'user': instance.user,
      'doctor': instance.doctor,
      'tumor': instance.tumor,
    };
