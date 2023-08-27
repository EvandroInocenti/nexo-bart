import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:nexo_onco/models/treatment.dart';
import 'package:nexo_onco/models/treatment_patient.dart';
import 'package:provider/provider.dart';

import '../models/cicle.dart';
import '../models/cicle_list.dart';
import '../models/drugs.dart';
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
  Patient get patient => ModalRoute.of(context)?.settings.arguments as Patient;
  final _formKey = GlobalKey<FormState>();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  TreatmentPatient treatmentPatient = TreatmentPatient();
  Treatment treatment = Treatment();
  Drugs drug = Drugs();
  Cicle cicle = Cicle();
  List<Drugs>? selectedDrugs = [];
  bool _isLoading = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // selectedDrugs = null;
  }

  Future<void> _submitForm() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<TreatmentPatientList>(
        context,
        listen: false,
      ).saveTreatmentPatient(treatmentPatient);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!',
              style: Theme.of(context).textTheme.titleLarge),
          content: Text('Ocorreu erro ao salvar o tratamento do paciente.',
              style: Theme.of(context).textTheme.titleMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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

    treatmentPatient.patient_id = patient.id;

    Future _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023 - 100),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Theme.of(context).colorScheme.primary,
                  onSurface: Theme.of(context).colorScheme.primary,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context)
                        .colorScheme
                        .primary, // button text color
                  ),
                ),
              ),
              child: child!);
        },
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
      _multiSelectKey.currentState!.reset();
      // keyTratamento.currentState!.reset();
      // keyQuimioterapico.currentState!.reset();
      // keyCiclo.currentState!.reset();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
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
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 8, 0),
                                border: const OutlineInputBorder(),
                                label: Text(
                                  'Tratamento anterior',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              // value: treatmentPatient.id ?? '1',
                              // value: '4',
                              onChanged: (newValue) {
                                treatmentPatient.id =
                                    int.tryParse(newValue!.toString());
                              },
                              items: treatmentsPatient.items
                                  .map<DropdownMenuItem<String>>(
                                      (treatmentPatient) {
                                return DropdownMenuItem(
                                  value: treatmentPatient.id.toString(),
                                  child: Text(
                                    '${treatmentPatient.getformatedDate(treatmentPatient.start_date!)} ${' - '} ${treatmentPatient.treatment!.name!}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: clearFields,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 8),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
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
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 8, 0),
                                border: const OutlineInputBorder(),
                                label: Text(
                                  'Tratamento',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              // value: treatment.id ?? '1',
                              // value: '1',
                              onChanged: (newValue) {
                                treatment.id =
                                    int.tryParse(newValue!.toString());
                              },
                              onSaved: (newValue) {
                                treatment.id =
                                    int.tryParse(newValue!.toString());
                                treatment.name =
                                    treatments.getTreatment(treatment.id!).name;
                                treatmentPatient.treatment = treatment;
                                treatmentPatient.treatment_id =
                                    treatmentPatient.id;
                                treatmentPatient.treatment!.name =
                                    treatment.name;
                              },
                              items: treatments.items
                                  .map<DropdownMenuItem<String>>((treatment) {
                                return DropdownMenuItem(
                                  value: treatment.id.toString(),
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
                            final listDrugs = drugs
                                .getDrugs()
                                .map((e) => MultiSelectItem<Drugs?>(e, e.name!))
                                .toList();
                            return MultiSelectBottomSheetField<Drugs?>(
                              key: _multiSelectKey,
                              initialChildSize: 0.7,
                              maxChildSize: 0.95,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                shape: BoxShape.rectangle,
                              ),
                              buttonIcon:
                                  const Icon(Icons.arrow_drop_down_sharp),
                              title: Text(
                                "Quimioterápico",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              buttonText: Text(
                                "Quimioterápico",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              confirmText: Text(
                                "Confirmar",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              cancelText: Text(
                                "Cancelar",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              items: listDrugs,
                              searchable: true,
                              onConfirm: (values) {
                                setState(() {
                                  for (var element in values) {
                                    selectedDrugs!.add(element!);
                                  }
                                });
                                _multiSelectKey.currentState!.validate();
                              },
                              checkColor: Theme.of(context).colorScheme.primary,
                              selectedColor: Colors.indigo.shade50,
                              chipDisplay: MultiSelectChipDisplay(
                                chipColor: Colors.indigo.shade50,
                                textStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                onTap: (item) {
                                  setState(() {
                                    selectedDrugs!.remove(item);
                                  });
                                  _multiSelectKey.currentState!.validate();
                                },
                              ),
                              onSaved: (value) =>
                                  treatmentPatient.drugs = value!,
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(16, 0, 8, 0),
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(16, 0, 8, 0),
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
                                contentPadding:
                                    const EdgeInsets.fromLTRB(16, 0, 8, 0),
                                border: const OutlineInputBorder(),
                                label: Text(
                                  'Ciclo',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              // value: cicle.id ?? '1',
                              // value: '1',
                              onChanged: (newValue) {
                                cicle.id = int.tryParse(newValue.toString());
                                cicle.number =
                                    cicles.getCicle(cicle.id!).number;
                                _doseTotalController.text = treatmentPatient
                                    .getDoseTotal(
                                        double.tryParse(_doseController.text),
                                        cicle.number!)
                                    .toString();
                              },
                              onSaved: (newValue) {
                                cicle.id = int.tryParse(newValue.toString());
                                cicle.name = cicles.getCicle(cicle.id!).name;
                                cicle.days = cicles.getCicle(cicle.id!).days;
                                cicle.number =
                                    cicles.getCicle(cicle.id!).number;
                                treatmentPatient.ciclo_id =
                                    int.tryParse(newValue.toString());
                                treatmentPatient.cicle = cicle;
                              },
                              items: cicles.items
                                  .map<DropdownMenuItem<String>>((cicle) {
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
                          controller: _doseTotalController,
                          decoration: InputDecoration(
                            label: Text('Dose cumulativa',
                                style: Theme.of(context).textTheme.bodyMedium),
                            border: const OutlineInputBorder(gapPadding: 3),
                            contentPadding:
                                const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          ),
                          obscureText: false,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          onSaved: (dose) {
                            treatmentPatient.dose_total = dose ?? '';
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            _formKey.currentState!.save();
                            _submitForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text("Salvar",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
