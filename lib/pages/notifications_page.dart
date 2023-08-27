import 'package:flutter/material.dart';
import 'package:nexo_onco/services/patient_notifications_service.dart';
import 'package:provider/provider.dart';

import '../models/patient_notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return NotificationWidget();
  }
}

class NotificationWidget extends State<NotificationsPage> {
  List<PatientNotification> items = [];

  @override
  void initState() {
    super.initState();
    final service =
        Provider.of<PatientNotificationService>(context, listen: false);

    service.fetchNotifications().then((value) {
      setState(() {
        items = value;
      });
    });
  }

  void remove(int id) {
    final service =
        Provider.of<PatientNotificationService>(context, listen: false);

    service.remove(id).then((value) {
      service.fetchNotifications().then((value) {
        setState(() {
          items = value;
        });
        Provider.of<PatientNotificationService>(context, listen: false)
            .notifyListeners();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Minhas Notificações',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            items[i].title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            items[i].body,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: () => remove(items[i].id),
        ),
      ),
    );
  }
}
