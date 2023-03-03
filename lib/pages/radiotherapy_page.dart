import 'package:flutter/material.dart';
import 'package:nexo_onco/components/adaptative_dropdown_button_form_field.dart';
import 'package:provider/provider.dart';

import '../models/treatment_patient.dart';
import '../models/treatment_patient_list.dart';

class RadiotherapyPage extends StatefulWidget {
  RadiotherapyPage({super.key});

  @override
  State<RadiotherapyPage> createState() => _RadiotherapyPageState();
}

class _RadiotherapyPageState extends State<RadiotherapyPage> {
  // TreatmentPatient get treatmentPatient =>
  //     ModalRoute.of(context)?.settings.arguments as TreatmentPatient;

  @override
  void initState() {
    super.initState();
    Provider.of<TreatmentPatientList>(context, listen: false)
        .loadTreatmentPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Consumer<TreatmentPatientList>(
                  builder: (ctx, treatmentsPatient, child) {
                    return AdaptativeDropdownButtonFormField(
                      label: 'Tratamento anterior',
                      value: 'Selecione',
                      items: treatmentsPatient.items
                          .map<DropdownMenuItem<String>>((treatmentPatient) {
                        return DropdownMenuItem(
                          value: treatmentPatient.treatment!.name,
                          child: Text(
                              '${treatmentPatient.startDate} ${' - '} ${treatmentPatient.treatment!.name}'),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
