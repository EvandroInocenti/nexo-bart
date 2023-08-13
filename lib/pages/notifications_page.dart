import 'package:flutter/material.dart';
import 'package:nexo_onco/services/patient_notifications_service.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<PatientNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Notificações'),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(
            items[i].title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            items[i].body,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
