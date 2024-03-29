import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cicle.g.dart';

@JsonSerializable()
class Cicle with ChangeNotifier {
  int? id;
  String? name;
  int? days;
  int? number;

  Cicle({
    this.id,
    this.name,
    this.days,
    this.number,
  });

  factory Cicle.fromJson(Map<String, dynamic> json) => _$CicleFromJson(json);
  Map<String, dynamic> toJson() => _$CicleToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
