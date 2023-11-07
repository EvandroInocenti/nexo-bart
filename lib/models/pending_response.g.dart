// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingResponse _$PendingResponseFromJson(Map<String, dynamic> json) =>
    PendingResponse(
      title: json['title'] as String?,
      date: json['date'] as String?,
      period: json['period'] as String?,
    );

Map<String, dynamic> _$PendingResponseToJson(PendingResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date,
      'period': instance.period,
    };
