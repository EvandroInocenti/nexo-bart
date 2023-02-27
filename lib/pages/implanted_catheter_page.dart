import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/patient_list.dart';

class ImplantedCatheterPage extends StatefulWidget {
  const ImplantedCatheterPage({super.key});

  @override
  State<ImplantedCatheterPage> createState() => _ImplantedCatheterPageState();
}

class _ImplantedCatheterPageState extends State<ImplantedCatheterPage> {
  final _catheterFocus = FocusNode();
  final _catheterPainFocus = FocusNode();
  final _catheterSwollenFocus = FocusNode();
  final _catheterHotFocus = FocusNode();
  final _catheterLiquidFocus = FocusNode();

  final _formData = <String, Object>{};

  @override
  void dispose() {
    super.dispose();
    _catheterFocus.dispose();
    _catheterHotFocus.dispose();
    _catheterLiquidFocus.dispose();
    _catheterPainFocus.dispose();
    _catheterSwollenFocus.dispose();
  }

  void _submitForm() {
    Provider.of<PatientList>(
      context,
      listen: false,
    ).savePatient(_formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Patient;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.titleLarge,
              children: const <TextSpan>[
                TextSpan(
                  text: 'Responda as perguntas em relação catéter implantado',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch(
                  focusNode: _catheterFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.catheter,
                  onChanged: (value) {
                    setState(() {
                      arg.switchCatheter(value);
                      if (arg.catheter == false) {
                        arg.catheter_hot = false;
                        arg.catheter_liquid = false;
                        arg.catheter_pain = false;
                        arg.catheter_swollen = false;
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Possui catéter implantado?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch(
                  focusNode: _catheterPainFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.catheter_pain,
                  onChanged: (value) {
                    arg.catheter == true
                        ? setState(() {
                            arg.switchCatheterPain(value);
                          })
                        : arg.catheter_pain = false;
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Sente dor no local?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch(
                  focusNode: _catheterSwollenFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.catheter_swollen,
                  onChanged: (value) {
                    arg.catheter == true
                        ? setState(() {
                            arg.switchCatheterSwollen(value);
                          })
                        : arg.catheter_swollen = false;
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'O local está inchado?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch(
                  focusNode: _catheterHotFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.catheter_hot,
                  onChanged: (value) {
                    arg.catheter == true
                        ? setState(() {
                            arg.switchCatheterHot(value);
                          })
                        : arg.surgery_hot = false;
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Sente o local quente?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch(
                  focusNode: _catheterLiquidFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.catheter_liquid,
                  onChanged: (value) {
                    arg.catheter == true
                        ? setState(() {
                            arg.switchCatheterLiquid(value);
                          })
                        : arg.catheter_liquid = false;
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: Text(
                  'Há liquido saindo da ferida?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          "Salvar",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
