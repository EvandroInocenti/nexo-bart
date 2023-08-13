import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nexo_onco/main.dart';
import 'package:nexo_onco/models/patient_notification.dart';
import 'package:nexo_onco/utils/app_routes.dart';

class PatientNotificationService with ChangeNotifier {
  List<PatientNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<PatientNotification> get items {
    return [..._items];
  }

  void add(PatientNotification notification) {
    _items.add(notification);
    if (kDebugMode) {
      print(_items.length);
    }
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    if (kDebugMode) {
      print(_items.length);
    }
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

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');

    // add(
    //   PatientNotification(
    //     title: message.notification!.title ?? 'Sem usuário!',
    //     body: message.notification!.body ?? 'Não informado!',
    //   ),
    // );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      AppRoutes.route,
      arguments: message,
    );

    // add(
    //   PatientNotification(
    //     title: message.notification!.title ?? 'Sem usuário!',
    //     body: message.notification!.body ?? 'Não informado!',
    //   ),
    // );
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

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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
        add(
          PatientNotification(
            title: message.notification!.title ?? 'Sem usuário!',
            body: message.notification!.body ?? 'Não informado!',
          ),
        );
      },
    );
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    print('Token: $fCMToken');

    initPushNotifications();
    initLocalNotifications();
  }
}
