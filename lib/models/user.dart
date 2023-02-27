// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User with ChangeNotifier {
  int? id;
  String name;
  String email;
  String? remember_me_token;
  String? role;
  String? cpf;
  String? telefone;
  bool? confirmed;
  int? institution_id;

  User({
    this.id,
    required this.name,
    required this.email,
    this.remember_me_token,
    this.role,
    this.cpf,
    this.telefone,
    this.confirmed = false,
    this.institution_id,
  });

  void switchConfirmed(bool value) {
    confirmed = value;
    notifyListeners();
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
