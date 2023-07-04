import 'package:firebase_messaging/firebase_messaging.dart';
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
    notifyListeners();
  }

  // Push Notification
  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAutorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAutorized) {
      FirebaseMessaging.onMessage.listen(_messegeHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAutorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messegeHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAutorized) {
      RemoteMessage? initialMsg =
          await FirebaseMessaging.instance.getInitialMessage();
      _messegeHandler(initialMsg);
    }
  }

  void _messegeHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;
    add(PatientNotification(
      patientName: msg.notification!.title ?? 'Sem usuário!',
      text: msg.notification!.body ?? 'Não informado!',
    ));
  }
}
