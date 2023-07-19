import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();

//     print('Token: ${fCMToken}');
//     await _configureTerminated();
//     await _configureForeground();
//     await _configureBackground();
//   }

//   Future<bool> get _isAutorized async {
//     final messaging = FirebaseMessaging.instance;
//     final settings = await messaging.requestPermission();
//     return settings.authorizationStatus == AuthorizationStatus.authorized;
//   }

//   Future<void> _configureForeground() async {
//     if (await _isAutorized) {
//       FirebaseMessaging.onMessage.listen(_messegeHandler);
//     }
//   }

//   Future<void> _configureBackground() async {
//     if (await _isAutorized) {
//       FirebaseMessaging.onMessageOpenedApp.listen(_messegeHandler);
//     }
//   }

//   Future<void> _configureTerminated() async {
//     if (await _isAutorized) {
//       RemoteMessage? initialMsg =
//           await FirebaseMessaging.instance.getInitialMessage();
//       _messegeHandler(initialMsg);
//     }
//   }

// // Verificar handler
//   void _messegeHandler(RemoteMessage? msg) {
//     if (msg == null || msg.notification == null) return;
//     add(PatientNotification(
//       patientName: msg.notification!.title ?? 'Sem usuário!',
//       text: msg.notification!.body ?? 'Não informado!',
//       msgFire: msg.messageId ?? 'Id não informado!',
//     ));
//   }

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');

    add(
      PatientNotification(
        title: message.notification!.title ?? 'Sem usuário!',
        body: message.notification!.body ?? 'Não informado!',
      ),
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // add(
    //   PatientNotification(
    //     title: message.notification!.title ?? 'Sem usuário!',
    //     body: message.notification!.body ?? 'Não informado!',
    //   ),
    // );
  }

  Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
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

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_chanel',
    'High Important Notifications',
    description: 'This chanel is used for important notification',
    importance: Importance.defaultImportance,
  );

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
      (message) {
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
              icon: '@drawable/ic_launcher',
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

    print('Token: ${fCMToken}');
    initPushNotifications();
    initLocalNotifications();
  }
}
