import 'package:flutter/material.dart';
import 'package:nexo_onco/components/adaptative_dropdown_button_form_field.dart';
import 'package:nexo_onco/models/treatment.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/treatment_list.dart';
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
    Future.delayed(Duration.zero, () {
      final patient = ModalRoute.of(context)?.settings.arguments as Patient;
      Provider.of<TreatmentPatientList>(context, listen: false)
          .loadTreatmentPatient(patient.id);
    });

    Provider.of<TreatmentList>(context, listen: false).loadTreatment();
  }

  @override
  Widget build(BuildContext context) {
    Treatment treatment = Treatment();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Consumer<TreatmentPatientList>(
                  builder: (ctx, treatmentsPatient, child) {
                    return AdaptativeDropdownButtonFormField(
                      label: 'Tratamento anterior',
                      // value: treatmentPatient.id.toString(),
                      items: treatmentsPatient.items
                          .map<DropdownMenuItem<String>>((treatmentPatient) {
                        return DropdownMenuItem(
                          value: treatmentPatient.id.toString(),
                          child: Text(
                            // '${treatmentPatient.startDate} ${' - '} ${treatmentPatient.id}'),
                            treatmentPatient.id.toString(),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Incluir",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Consumer<TreatmentList>(
                  builder: (ctx, treatments, child) {
                    return AdaptativeDropdownButtonFormField(
                      label: 'Tratamento',
                      value: treatment.name,
                      onChanged: (newValue) {
                        treatment.name = newValue;
                      },
                      items: treatments.items
                          .map<DropdownMenuItem<String>>((treatment) {
                        return DropdownMenuItem(
                          value: treatment.name,
                          child: Text(treatment.name!),
                        );
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
