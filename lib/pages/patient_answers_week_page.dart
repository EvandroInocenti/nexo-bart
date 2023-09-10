import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexo_onco/models/patient_answers.dart';
import 'package:nexo_onco/models/patient_answers_list.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/patient_list.dart';
import '../utils/app_routes.dart';

class patientAnswersWeekPage extends StatefulWidget {
  patientAnswersWeekPage({
    super.key,
  });

  @override
  State<patientAnswersWeekPage> createState() => _PatienAnswersState();
}

class _PatienAnswersState extends State<patientAnswersWeekPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int _activeStateIndex = 0;
  bool isCompleted = false;
  PatientAnswers? patientAnswares;
  final _temperatureCtrl = TextEditingController();

  List<Step> stepList() => [
        Step(
          state:
              _activeStateIndex <= 0 ? StepState.disabled : StepState.complete,
          isActive: _activeStateIndex >= 0,
          title: const Text(''),
          content: Column(
            children: [
              Text(
                'Perdeu o apetite na última semana?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) {
                  patientAnswares!.difficulty_breathing =
                      value == "Sim" ? true : false;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Sentiu algum tipo de perda de força muscular?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) {
                  patientAnswares!.difficulty_breathing =
                      value == "Sim" ? true : false;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'A perda de força limitou ou impediu a realização de alguma atividade? Qual?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                // width: 380,
                child: GestureDetector(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.singleLineFormatter
                    // ],
                    maxLines: 3,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                      border: OutlineInputBorder(),
                      labelText: 'Limitação por perda de força',
                    ),
                    // maxLength: 2,
                    controller: _temperatureCtrl,
                    onChanged: (value) => patientAnswares?.temperature =
                        int.parse(_temperatureCtrl.text),
                    validator: (value) {
                      final temperatura = value ?? '';
                      if (temperatura.trim().isEmpty) {
                        return 'Informe a limitação.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      patientAnswares?.temperature = int.parse(value!);
                    },
                  ),
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Teve dificuldade para dormir?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) =>
                    patientAnswares!.convulsion = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Step(
          state:
              _activeStateIndex <= 1 ? StepState.disabled : StepState.complete,
          isActive: _activeStateIndex >= 1,
          title: const Text(''),
          content: Column(
            children: [
              Text(
                'Teve problema emocional?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) =>
                    patientAnswares!.body_ache = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Teve problema sexual?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) =>
                    patientAnswares!.tiredness = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                // width: 250,
                child: GestureDetector(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.singleLineFormatter
                    // ],
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                      border: OutlineInputBorder(),
                      labelText: 'Se desejar informe qual',
                    ),
                    // maxLength: 2,
                    controller: _temperatureCtrl,
                    onChanged: (value) => patientAnswares?.temperature =
                        int.parse(_temperatureCtrl.text),
                    validator: (value) {
                      final temperatura = value ?? '';
                      if (temperatura.trim().isEmpty) {
                        return 'Problema sexual.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      patientAnswares?.temperature = int.parse(value!);
                    },
                  ),
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                ),
              ),
              Text(
                'Tem percebido problemas de memória?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                shapeRadius: 10,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                selectedBorderColor: Colors.transparent,
                unSelectedBorderColor: Colors.transparent,
                absoluteZeroSpacing: false,
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: Theme.of(context).textTheme.titleLarge!,
                ),
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: (value) =>
                    patientAnswares!.mouth_sore = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ];

  @override
  void initState() {
    super.initState();
    Provider.of<PatientList>(context, listen: false).loadPatients();
    patientAnswares = PatientAnswers(
      temperature: int.tryParse(_temperatureCtrl.text) ?? 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _temperatureCtrl.dispose();
  }

  Future<void> _submitAnswers() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<PatientAnswersList>(
        context,
        listen: false,
      ).savePatientAnswers(patientAnswares!);
    } catch (error) {
      // ignore: use_build_context_synchronously
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: Icon(
            Icons.error_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text('Ocorreu um erro!',
              style: Theme.of(context).textTheme.titleLarge),
          content: Text(
              'Ocorreu erro ao salvar o questionamento, tente novamente mais tarde.',
              style: Theme.of(context).textTheme.titleMedium),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.authOrHome,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                'Fechar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
    final isLastStep = _activeStateIndex == stepList().length - 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: Text(
          'Acompanhamento clínico semanal',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
      ),
      body: isCompleted
          ? ListView(
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.cloud_done,
                      color: Theme.of(context).colorScheme.primary,
                      size: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Respostas enviadas!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (patientAnswares!.temperature! > 37.5 ||
                                  patientAnswares!.convulsion! ||
                                  patientAnswares!.difficulty_breathing!)
                              ? Container(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      FadeAnimatedText(
                                        'Atenção!',
                                        textStyle: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      FadeAnimatedText(
                                        'Procure o serviço médico!',
                                        textStyle: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                    totalRepeatCount: 30,
                                    // pause: const Duration(milliseconds: 1000),
                                    // displayFullTextOnTap: true,
                                    // stopPauseOnTap: true,
                                    // onTap: () {
                                    //   print("Tap Event");
                                    // },
                                  ),
                                )
                              : const Text('Tenha um ótimo dia!'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Sair',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ],
            )
          : _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: _activeStateIndex,
                    steps: stepList(),
                    onStepContinue: () async {
                      if (isLastStep) {
                        await _submitAnswers();
                        setState(() {
                          isCompleted = true;
                        });

                        if (kDebugMode) {
                          print('complete');
                        }
                      } else {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        setState(() {
                          _activeStateIndex += 1;
                        });
                      }
                    },
                    onStepCancel: () {
                      _activeStateIndex == 0
                          ? null
                          : setState(() {
                              _activeStateIndex -= 1;
                            });
                    },
                    onStepTapped: (index) {
                      setState(() {
                        _activeStateIndex = index;
                      });
                    },
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      isLastStep ? 'Confirmar' : 'Próximo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (_activeStateIndex != 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: details.onStepCancel,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Voltar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
