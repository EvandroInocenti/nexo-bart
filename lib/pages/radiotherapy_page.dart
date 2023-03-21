import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:nexo_onco/components/adaptative_dropdown_button_form_field.dart';
import 'package:nexo_onco/models/treatment.dart';
import 'package:nexo_onco/models/treatment_patient.dart';
import 'package:provider/provider.dart';

import '../components/adaptative_text_form_field.dart';
import '../models/cicle.dart';
import '../models/cicle_list.dart';
import '../models/drug.dart';
import '../models/drugs_list.dart';
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

  final TextEditingController _startDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final patient = ModalRoute.of(context)?.settings.arguments as Patient;
      Provider.of<TreatmentPatientList>(context, listen: false)
          .loadTreatmentPatient(patient.id);
    });

    Provider.of<TreatmentList>(context, listen: false).loadTreatment();
    Provider.of<DrugList>(context, listen: false).loadDrugs();
    Provider.of<CicleList>(context, listen: false).loadCicles();
  }

  @override
  Widget build(BuildContext context) {
    TreatmentPatient treatmentPatient = TreatmentPatient();
    Treatment treatment = Treatment();
    Drug drug = Drug();
    Cicle cicle = Cicle();

    // _startDateController.text = treatmentPatient.startDate!;
    // DateTime parseDate =
    //     DateFormat("yyyy-MM-dd").parse(treatmentPatient.startDate!);
    // String dateFormat = DateFormat('dd/MM/yyyy').format(parseDate);

    // final TextEditingController dateControllerFormat =
    //     TextEditingController(text: dateFormat);

    // Future _selectDate() async {
    //   DateTime? picked = await showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(2023 - 100),
    //     lastDate: DateTime.now(),
    //   );
    //   if (picked != null) {
    //     String formatDate = DateFormat('dd/MM/yyyy').format(picked);
    //     String dateDb = DateFormat('yyyy-MM-dd').format(picked);
    //     setState(
    //       () => {
    //         treatmentPatient.startDate = dateDb,
    //         _startDateController.text = formatDate,
    //       },
    //     );
    //   } else {
    //     if (kDebugMode) {
    //       print("Data não selecionada");
    //     }
    //   }
    // }

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
                      onChanged: (newValue) {
                        treatmentPatient.treatment!.name = newValue;
                      },
                      items: treatmentsPatient.items
                          .map<DropdownMenuItem<String>>((treatmentPatient) {
                        return DropdownMenuItem(
                          value: treatmentPatient.treatment!.name,
                          child: Text(
                              '${treatmentPatient.getformatDate(treatmentPatient.start_date!)} ${' - '} ${treatmentPatient.treatment!.name!}'),
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
                flex: 2,
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
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Consumer<DrugList>(
                  builder: (ctx, drugs, child) {
                    return AdaptativeDropdownButtonFormField(
                      label: 'Quimioterápico',
                      value: drug.name,
                      onChanged: (newValue) {
                        drug.name = newValue;
                      },
                      items: drugs.items.map<DropdownMenuItem<String>>((drug) {
                        return DropdownMenuItem(
                          value: drug.name,
                          child: Text(drug.name!),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AdaptativeTextFormField(
                  // focusNode: _birthDateFocus,
                  label: 'Data de início',
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_heightFocus);
                  // },
                  onSaved: (dataInicio) =>
                      treatmentPatient.start_date = dataInicio ?? '',
                  validator: (_dataInicio) {
                    final dataInicio = _dataInicio ?? '';
                    if (dataInicio.trim().isEmpty) {
                      return 'Data de início do tratamento é obrigatória';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: AdaptativeTextFormField(
                  label: 'Dose/m2',
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (dose) => treatmentPatient.dose = dose ?? '',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Consumer<CicleList>(
                  builder: (ctx, cicles, child) {
                    return AdaptativeDropdownButtonFormField(
                      label: 'Ciclos',
                      value: cicle.name,
                      onChanged: (newValue) {
                        cicle.name = newValue;
                      },
                      items:
                          cicles.items.map<DropdownMenuItem<String>>((cicle) {
                        return DropdownMenuItem(
                          value: cicle.name,
                          child: Text(cicle.name!),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: AdaptativeTextFormField(
                    initialValue: treatmentPatient.dose_total,
                    label: 'Dose cumulativa',
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onSaved: (dose) {
                      int? doseTotal =
                          int.tryParse(treatmentPatient.dose_total!);
                      int? intDose = int.tryParse(dose!);
                      int doseAcumulada = doseTotal! + intDose!;
                      if (doseAcumulada > 0) {
                        treatmentPatient.dose_total = doseAcumulada.toString();
                      } else {
                        treatmentPatient.dose_total = treatmentPatient.dose;
                      }

                      print(doseAcumulada);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
