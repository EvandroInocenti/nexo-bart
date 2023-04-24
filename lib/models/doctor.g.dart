// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map json) => Doctor(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      remember_me_token: json['remember_me_token'] as bool?,
      role: json['role'] as String?,
      cpf: json['cpf'] as String?,
      telefone: json['telefone'] as String?,
      confirmed: json['confirmed'] as bool?,
      institution_id: json['institution_id'] as int?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'remember_me_token': instance.remember_me_token,
      'role': instance.role,
      'cpf': instance.cpf,
      'telefone': instance.telefone,
      'confirmed': instance.confirmed,
      'institution_id': instance.institution_id,
    };
