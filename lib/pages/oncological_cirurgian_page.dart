import 'package:flutter/material.dart';

import '../models/patient.dart';

class OncologicalCirurgianPage extends StatefulWidget {
  OncologicalCirurgianPage({super.key});

  @override
  State<OncologicalCirurgianPage> createState() =>
      _OncologicalCirurgianPageState();
}

class _OncologicalCirurgianPageState extends State<OncologicalCirurgianPage> {
  final _surgeryFocus = FocusNode();
  final _surgeryPainFocus = FocusNode();
  final _surgerySwollenFocus = FocusNode();
  final _surgeryHotFocus = FocusNode();
  final _surgeryLiquidFocus = FocusNode();

  final _formData = <String, Object>{};

  @override
  void dispose() {
    super.dispose();
    _surgeryFocus.dispose();
    _surgeryHotFocus.dispose();
    _surgeryLiquidFocus.dispose();
    _surgeryPainFocus.dispose();
    _surgerySwollenFocus.dispose();
  }

  void _submitForm() {
    // Provider.of<PatientList>(
    //   context,
    //   listen: false,
    // ).savePatient(_formData);

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
                  text: 'Responda as perguntas em relação à ferida operatória',
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
                  focusNode: _surgeryFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.surgery,
                  onChanged: (value) {
                    setState(() {
                      arg.switchSurgery(value);
                      if (arg.surgery == false) {
                        arg.surgery_hot = false;
                        arg.surgery_liquid = false;
                        arg.surgery_pain = false;
                        arg.surgery_swollen = false;
                      }
                    });
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 8,
                child: Text(
                  'Possui cirurgia oncológica recente?',
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
                  focusNode: _surgeryPainFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.surgery_pain,
                  onChanged: (value) {
                    arg.surgery == true
                        ? setState(() {
                            arg.switchSurgeryPain(value);
                          })
                        : arg.surgery_pain = false;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 8,
                child: Text(
                  'Sente dor na ferida?',
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
                  focusNode: _surgerySwollenFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.surgery_swollen,
                  onChanged: (value) {
                    arg.surgery == true
                        ? setState(() {
                            arg.switchSurgerySwollen(value);
                          })
                        : arg.surgery_swollen = false;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 8,
                child: Text(
                  'A ferida está inchada?',
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
                  focusNode: _surgeryHotFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.surgery_hot,
                  onChanged: (value) {
                    arg.surgery == true
                        ? setState(() {
                            arg.switchSurgeryHot(value);
                          })
                        : arg.surgery_hot = false;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 8,
                child: Text(
                  'Sente a ferida quente?',
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
                  focusNode: _surgeryLiquidFocus,
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: arg.surgery_liquid,
                  onChanged: (value) {
                    arg.surgery == true
                        ? setState(() {
                            arg.switchSurgeryLiquid(value);
                          })
                        : arg.surgery_liquid = false;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 8,
                child: Text(
                  'Há liquido saindo do local?',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          // const Divider(),
          // const SizedBox(height: 20),
          // Column(
          //   children: [
          //     Container(
          //       alignment: Alignment.bottomCenter,
          //       child: ElevatedButton(
          //         onPressed: _submitForm,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Icon(Icons.check),
          //             Padding(
          //               padding: const EdgeInsets.all(14.0),
          //               child: Text(
          //                 "Salvar",
          //                 style: Theme.of(context).textTheme.labelLarge,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
