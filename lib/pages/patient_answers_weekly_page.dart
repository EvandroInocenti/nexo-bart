import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/patient_list.dart';
import '../models/patient_weekly_answers.dart';
import '../models/patient_weekly_answers_list.dart';
import '../models/pending_response_list.dart';
import '../utils/app_routes.dart';

class PatientWeeklyAnswersPage extends StatefulWidget {
  PatientWeeklyAnswersPage({
    super.key,
  });

  @override
  State<PatientWeeklyAnswersPage> createState() => _PatienWeeklyAnswersState();
}

class _PatienWeeklyAnswersState extends State<PatientWeeklyAnswersPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int _activeStateIndex = 0;
  bool isCompleted = false;
  PatientWeeklyAnswers? patientWeeklyAnswares;

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
                defaultSelected: 'Não',
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
                  patientWeeklyAnswares!.lost_appetite =
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
                defaultSelected: 'Não',
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
                  patientWeeklyAnswares!.lost_strength =
                      value == "Sim" ? true : false;
                },
              ),
              const SizedBox(height: 20),
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
                defaultSelected: 'Não',
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
                radioButtonValue: (value) => patientWeeklyAnswares!
                    .difficulty_sleeping = value == "Sim" ? true : false,
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
                defaultSelected: 'Não',
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
                radioButtonValue: (value) => patientWeeklyAnswares!
                    .emotional_problem = value == "Sim" ? true : false,
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
                defaultSelected: 'Não',
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
                radioButtonValue: (value) => patientWeeklyAnswares!
                    .sexual_problem = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
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
                defaultSelected: 'Não',
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
                radioButtonValue: (value) => patientWeeklyAnswares!
                    .memory_problem = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Percebeu problemas de concentração?',
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
                defaultSelected: 'Não',
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
                radioButtonValue: (value) => patientWeeklyAnswares!
                    .concentration_problem = value == "Sim" ? true : false,
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
    patientWeeklyAnswares = PatientWeeklyAnswers(
      concentration_problem: false,
      difficulty_sleeping: false,
      emotional_problem: false,
      lost_appetite: false,
      lost_strength: false,
      memory_problem: false,
      sexual_problem: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _temperatureCtrl.dispose();
  }

  Future<void> _submitAnswers() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<PatientWeeklyAnswersList>(
        context,
        listen: false,
      ).savePatientWeeklyAnswers(patientWeeklyAnswares!);
    } catch (error) {
      // ignore: use_build_context_synchronously
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          icon: Icon(
            Icons.error_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(error.toString(),
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
      body: FutureBuilder(
        future: Provider.of<PendingResponseList>(context, listen: false)
            .fetchPendingResponse(),
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
            return isCompleted
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
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
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
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            isLastStep
                                                ? 'Confirmar'
                                                : 'Próximo',
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
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
                      );
          }
        },
      ),
    );
  }
}
