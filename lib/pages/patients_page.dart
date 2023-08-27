import 'package:flutter/material.dart';
import 'package:nexo_onco/pages/notifications_page.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/patient_item.dart';
import '../models/patient_list.dart';
import '../services/patient_notifications_service.dart';
import '../utils/app_routes.dart';
import 'dart:async';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Future<void> _refreshPatients(BuildContext context) {
    return Provider.of<PatientList>(context, listen: false).loadPatients();
  }

  int itemsCount = 0;

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      var itemsCountFuture =
          await Provider.of<PatientNotificationService>(context, listen: false)
              .itemsCount();
      if (itemsCount != itemsCountFuture) {
        setState(() {
          itemsCount = itemsCountFuture;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Pacientes',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.tabsPage,
              );
            },
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const NotificationsPage();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                    maxRadius: 10,
                    backgroundColor: Colors.red.shade800,
                    child: itemsCount < 99
                        ? Text(
                            '$itemsCount',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          )
                        : const Text(
                            '+99',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )),
              ),
            ],
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
        child: AppDrawer(),
      ),
      body: FutureBuilder(
        future: Provider.of<PatientList>(context, listen: false).loadPatients(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<PatientList>(
              builder: (ctx, patients, child) => RefreshIndicator(
                onRefresh: () => _refreshPatients(context),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: patients.itemsCount,
                    itemBuilder: (ctx, i) => Column(
                      children: [
                        PatientItem(patients.items[i]),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<PatientNotificationService>(
      //       context,
      //       listen: false,
      //     ).add(PatientNotification(
      //       title: 'Mais uma notificação',
      //       body: Random().nextDouble().toString(),
      //     ));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
