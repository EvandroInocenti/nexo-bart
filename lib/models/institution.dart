import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'institution.g.dart';

@JsonSerializable()
class Institution with ChangeNotifier {
  int? id;
  String? name;

  Institution({
    this.id,
    this.name,
  });

  factory Institution.fromJson(Map<String, dynamic> json) =>
      _$InstitutionFromJson(json);
  Map<String, dynamic> toJson() => _$InstitutionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
