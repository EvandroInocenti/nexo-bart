// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingResponse _$PendingResponseFromJson(Map<String, dynamic> json) =>
    PendingResponse(
      id: json['id'] as int?,
      title: json['title'] as String?,
      date: json['date'] as String?,
      period: json['period'] as String?,
    );

Map<String, dynamic> _$PendingResponseToJson(PendingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'period': instance.period,
    };
