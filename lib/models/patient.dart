// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';
import 'tumor.dart';
import 'user.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient with ChangeNotifier {
  final int id;
  String data_nascimento;
  int altura;
  int peso;
  double superficie_corporea;
  int? user_id;
  int? doctor_id;
  int? tumor_id;
  bool surgery;
  bool surgery_pain;
  bool surgery_swollen;
  bool surgery_hot;
  bool surgery_liquid;
  bool catheter;
  bool catheter_pain;
  bool catheter_swollen;
  bool catheter_hot;
  bool catheter_liquid;
  int staging;
  User? user;
  Doctor? doctor;
  Tumor? tumor;

  Patient({
    required this.id,
    required this.data_nascimento,
    required this.altura,
    required this.peso,
    required this.superficie_corporea,
    this.user_id,
    this.doctor_id,
    this.tumor_id,
    this.surgery = false,
    this.surgery_pain = false,
    this.surgery_swollen = false,
    this.surgery_hot = false,
    this.surgery_liquid = false,
    this.catheter = false,
    this.catheter_pain = false,
    this.catheter_swollen = false,
    this.catheter_hot = false,
    this.catheter_liquid = false,
    this.staging = 1,
    this.doctor,
    this.tumor,
    this.user,
  });

  void sliderStaging(int value) {
    staging = value;
    notifyListeners();
  }

  void switchSurgery(bool value) {
    surgery = value;
    notifyListeners();
  }

  void switchSurgeryPain(bool value) {
    surgery_pain = value;
    notifyListeners();
  }

  void switchSurgerySwollen(bool value) {
    surgery_swollen = value;
    notifyListeners();
  }

  void switchSurgeryHot(bool value) {
    surgery_hot = value;
    notifyListeners();
  }

  void switchSurgeryLiquid(bool value) {
    surgery_liquid = value;
    notifyListeners();
  }

  void switchCatheter(bool value) {
    catheter = value;
    notifyListeners();
  }

  void switchCatheterPain(bool value) {
    catheter_pain = value;
    notifyListeners();
  }

  void switchCatheterSwollen(bool value) {
    catheter_swollen = value;
    notifyListeners();
  }

  void switchCatheterHot(bool value) {
    catheter_hot = value;
    notifyListeners();
  }

  void switchCatheterLiquid(bool value) {
    catheter_liquid = value;
    notifyListeners();
  }

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
