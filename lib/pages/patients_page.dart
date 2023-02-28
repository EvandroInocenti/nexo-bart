import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/patient_item.dart';
import '../models/patient_list.dart';
import '../utils/app_routes.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  Future<void> _refreshPatients(BuildContext context) {
    return Provider.of<PatientList>(context, listen: false).loadPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            icon: const Icon(Icons.person_add_alt_1_rounded),
          ),
        ],
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
    );
  }
}
