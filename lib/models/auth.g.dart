// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      token: json['token'] as String?,
      email: json['email'] as String?,
      idPatient: json['idPatient'] as int?,
      role: json['role'] as String?,
      confirmed: json["confirmed"] == 1 ? true : false,
      institutionId: int.tryParse(json['institutionId']),
      firebaseToken: json['firebaseToken'] as String?,
      lastAccess:
          json['lastAccess'] == null ? null : json['lastAccess'] as String,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'token': instance.token,
      'email': instance.email,
      'idPatient': instance.idPatient,
      'role': instance.role,
      'confirmed': instance.confirmed,
      'institutionId': instance.institutionId,
      'firebaseToken': instance.firebaseToken,
      'lastAccess': instance.lastAccess?.toString(),
    };
