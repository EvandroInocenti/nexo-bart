import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/patient_list.dart';
import '../pages/tabs_page.dart';
import '../utils/app_routes.dart';

class PatientItem extends StatefulWidget {
  final Patient patient;
  const PatientItem(this.patient, {super.key});

  @override
  State<PatientItem> createState() => _PatientItemState();
}

class _PatientItemState extends State<PatientItem> {
  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    var nomeInicial = widget.patient.user!.name[0].toUpperCase();
    nomeInicial += widget.patient.user!.name[1].toUpperCase();
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            nomeInicial,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        title: Text(
          widget.patient.user!.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          widget.patient.user!.email,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: Container(
          width: 150,
          child: Row(
            children: [
              Flexible(
                child: Switch(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: widget.patient.user!.confirmed!,
                  onChanged: (value) {
                    setState(() {
                      widget.patient.user!.switchConfirmed(value);
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => TabsPage(widget.patient),
                  //   ),
                  // );
                  Navigator.of(context).pushNamed(
                    AppRoutes.tabsPage,
                    arguments: widget.patient,
                  );
                },
              ),
              IconButton(
                color: Theme.of(context).colorScheme.error,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'Excluir Paciente',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Text('Tem certeza?',
                          style: Theme.of(context).textTheme.titleMedium),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text('Não',
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        TextButton(
                          child: Text('Sim',
                              style: Theme.of(context).textTheme.titleMedium),
                          onPressed: () => Navigator.of(ctx).pop(true),
                        ),
                      ],
                    ),
                  ).then((value) async {
                    if (value ?? false) {
                      try {
                        await Provider.of<PatientList>(
                          context,
                          listen: false,
                        ).removePatient(widget.patient);
                      } on HttpException catch (error) {
                        msg.showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
