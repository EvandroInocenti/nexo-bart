import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_response.g.dart';

@JsonSerializable()
class PendingResponse with ChangeNotifier {
  int? id;
  String? title;
  String? date;
  String? period;

  PendingResponse({
    this.id,
    this.title,
    this.date,
    this.period,
  });

  factory PendingResponse.fromJson(Map<String, dynamic> json) =>
      _$PendingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PendingResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
