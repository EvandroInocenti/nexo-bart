import 'package:flutter/material.dart';
import 'package:nexo_onco/models/patient_notification.dart';

class PatientNotificationService with ChangeNotifier {
  List<PatientNotification> _items = [];

  List<PatientNotification> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(PatientNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
  }
}
