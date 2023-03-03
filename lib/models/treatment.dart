import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment.g.dart';

@JsonSerializable()
class Treatment with ChangeNotifier {
  int? id;
  String? name;

  Treatment({
    this.id,
    this.name,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) =>
      _$TreatmentFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
