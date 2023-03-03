import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart';

@JsonSerializable()
class Drug with ChangeNotifier {
  int? id;
  String? name;

  Drug({
    this.id,
    this.name,
  });

  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);
  Map<String, dynamic> toJson() => _$DrugToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
