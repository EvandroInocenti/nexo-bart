import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexo_onco/components/adaptative_dropdown_button_form_field.dart';
import 'package:nexo_onco/models/treatment.dart';
import 'package:nexo_onco/models/treatment_patient.dart';
import 'package:provider/provider.dart';

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
  TreatmentPatient treatmentPatient = TreatmentPatient();
  Treatment treatment = Treatment();
  Drug drug = Drug();
  Cicle cicle = Cicle();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _doseTotalController = TextEditingController();

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
  void dispose() {
    super.dispose();
    treatmentPatient.dispose();
    treatment.dispose();
    drug.dispose();
    cicle.dispose();
    _startDateController.dispose();
    _doseController.dispose();
    _doseTotalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final keyTratamento = GlobalKey<FormFieldState>();
    // final keyQuimioterapico = GlobalKey<FormFieldState>();
    // final keyCiclo = GlobalKey<FormFieldState>();
    _startDateController.text = treatmentPatient.start_date ??
        DateFormat("yyyy-MM-dd").format(DateTime.now());
    DateTime parseDate =
        DateFormat("yyyy-MM-dd").parse(_startDateController.text);
    String dateFormat = DateFormat('dd/MM/yyyy').format(parseDate);

    final TextEditingController dateControllerFormat =
        TextEditingController(text: dateFormat);

    Future _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023 - 100),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        String formatDate = DateFormat('dd/MM/yyyy').format(picked);
        String dateDb = DateFormat('yyyy-MM-dd').format(picked);
        setState(
          () => {
            treatmentPatient.start_date = dateDb,
            _startDateController.text = formatDate,
          },
        );
      } else {
        if (kDebugMode) {
          print("Data não selecionada");
        }
      }
    }

    void clearFields() {
      _startDateController.clear();
      _doseController.clear();
      _doseTotalController.clear();
      // keyTratamento.currentState!.reset();
      // keyQuimioterapico.currentState!.reset();
      // keyCiclo.currentState!.reset();
    }

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
                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Tratamento anterior',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      onChanged: (newValue) {
                        treatmentPatient.treatment!.name = newValue;
                      },
                      items: treatmentsPatient.items
                          .map<DropdownMenuItem<String>>((treatmentPatient) {
                        return DropdownMenuItem(
                          value: treatmentPatient.treatment!.name,
                          child: Text(
                              '${treatmentPatient.getformatedDate(treatmentPatient.start_date!)} ${' - '} ${treatmentPatient.treatment!.name!}'),
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
                      onPressed: clearFields,
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
                    return DropdownButtonFormField(
                      // key: keyTratamento,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Tratamento',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
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
                    return DropdownButtonFormField(
                      // key: keyQuimioterapico,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Quimioterápico',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
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
                child: TextFormField(
                  controller: dateControllerFormat,
                  decoration: InputDecoration(
                    label: Text('Data de início',
                        style: Theme.of(context).textTheme.bodyMedium),
                    border: const OutlineInputBorder(gapPadding: 3),
                    contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  ),
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    _selectDate();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onSaved: (startDate) {
                    DateTime parseStartDate =
                        DateFormat("dd/MM/yyyy").parse(startDate!);
                    String formatDateDb =
                        DateFormat('yyyy-MM-dd').format(parseStartDate);
                    treatmentPatient.start_date = formatDateDb;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Selecione uma data';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _doseController,
                  decoration: InputDecoration(
                    label: Text('Dose/m2',
                        style: Theme.of(context).textTheme.bodyMedium),
                    border: const OutlineInputBorder(gapPadding: 3),
                    contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  ),
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
                    return DropdownButtonFormField(
                      // key: keyCiclo,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Ciclo',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      // value: cicle.id.toString(),
                      value: '1',
                      onChanged: (newValue) {
                        cicle.id = int.tryParse(newValue!);
                        cicle.number = cicles.getNumberCicle(cicle.id!);
                        _doseTotalController.text = treatmentPatient
                            .getDoseTotal(double.tryParse(_doseController.text),
                                cicle.number!)
                            .toString();
                      },
                      items:
                          cicles.items.map<DropdownMenuItem<String>>((cicle) {
                        return DropdownMenuItem(
                          value: cicle.id.toString(),
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
                child: TextFormField(
                    enabled: false,
                    initialValue: treatmentPatient.dose_total,
                    controller: _doseTotalController,
                    decoration: InputDecoration(
                      label: Text('Dose cumulativa',
                          style: Theme.of(context).textTheme.bodyMedium),
                      border: const OutlineInputBorder(gapPadding: 3),
                      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    ),
                    obscureText: false,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onSaved: (dose) {
                      treatmentPatient.dose_total = dose ?? '';
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
