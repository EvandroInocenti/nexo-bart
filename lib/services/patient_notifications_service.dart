import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nexo_onco/main.dart';
import 'package:nexo_onco/models/patient_notification.dart';
import 'package:nexo_onco/services/databaseController.dart';
import 'package:nexo_onco/utils/app_routes.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  PatientNotificationService().add(
    PatientNotification(
      title: message.notification!.title ?? 'Sem usuário!',
      body: message.notification!.body ?? 'Não informado!',
      lida: 0,
      id: 0,
    ),
  );
}

Future<void> _message(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin _localNotifications,
    AndroidNotificationChannel _androidChannel) async {
  final notification = message.notification;
  if (notification == null) return;
  _localNotifications.show(
    notification.hashCode,
    notification.title,
    notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        icon: '@drawable/simbolo',
        enableVibration: true,
        playSound: true,
      ),
    ),
    payload: jsonEncode(message.toMap()),
  );
  print("recebido");

  PatientNotificationService().add(
    PatientNotification(
      title: message.notification!.title ?? 'Sem usuário!',
      body: message.notification!.body ?? 'Não informado!',
      lida: 0,
      id: 0,
    ),
  );
}

class PatientNotificationService with ChangeNotifier {
  List<PatientNotification> _items = [];
  Future<int> itemsCount() async {
    await fetchNotifications();
    notifyListeners();
    return _items.length;
  }

  Future<List<PatientNotification>> fetchNotifications() async {
    _items = await new DatabaseController().getNotificacao();
    notifyListeners();
    return _items;
  }

  Future<List<PatientNotification>> items() async {
    notifyListeners();

    return _items;
  }

  Future<void> add(PatientNotification notification) async {
    // Verificar se a notificação já existe na lista

    new DatabaseController()
        .insertNotificacao(notification.title, notification.body, 0);

    notifyListeners();
  }

  Future<void> remove(int i) async {
    new DatabaseController().deleteNotificacao(i);
    print("clicouprr" + i.toString());

    notifyListeners();
  }

  // Push Notification
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  // final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.route,
      arguments: message,
    );

    add(
      PatientNotification(
        title: message.notification!.title ?? 'Sem usuário!',
        body: message.notification!.body ?? 'Não informado!',
        lida: 0,
        id: 0,
      ),
    );
  }

  Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/simbolo');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  void initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(
        (message) => _message(message, _localNotifications, _androidChannel));
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    print('Token: $fCMToken');

    initPushNotifications();
    initLocalNotifications();
    fetchNotifications();
  }
}
