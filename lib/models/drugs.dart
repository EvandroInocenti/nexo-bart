import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drugs.g.dart';

@JsonSerializable()
class Drugs with ChangeNotifier {
  int? id;
  String? name;

  Drugs({
    this.id,
    this.name,
  });

  factory Drugs.fromJson(Map<String, dynamic> json) => _$DrugsFromJson(json);
  Map<String, dynamic> toJson() => _$DrugsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
