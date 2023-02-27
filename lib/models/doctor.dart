// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor with ChangeNotifier {
  final int? id;
  final String? name;
  final String? email;
  final bool? remember_me_token;
  final String? role;
  final String? cpf;
  final String? telefone;
  final bool? confirmed;
  final int? institution_id;
  Doctor({
    this.id,
    this.name,
    this.email,
    this.remember_me_token,
    this.role,
    this.cpf,
    this.telefone,
    this.confirmed,
    this.institution_id,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
