import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drug_tumor.g.dart';

@JsonSerializable()
class DrugTumor with ChangeNotifier {
  int? id;
  int? drug_id;
  int? tumor_id;

  DrugTumor({
    this.id,
    this.drug_id,
    this.tumor_id,
  });

  factory DrugTumor.fromJson(Map<String, dynamic> json) =>
      _$DrugTumorFromJson(json);
  Map<String, dynamic> toJson() => _$DrugTumorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
