import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tumor.g.dart';

@JsonSerializable()
class Tumor with ChangeNotifier {
  int? id;
  String? name;

  Tumor({
    this.id,
    this.name,
  });

  factory Tumor.fromJson(Map<String, dynamic> json) => _$TumorFromJson(json);
  Map<String, dynamic> toJson() => _$TumorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
