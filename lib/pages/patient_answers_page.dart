import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexo_onco/models/patient_answers.dart';
import 'package:provider/provider.dart';

import '../components/adaptative_custom_radio_button.dart';
import '../components/app_rating_bar.dart';
import '../models/patient_list.dart';

class PatientAnswersPage extends StatefulWidget {
  PatientAnswersPage({super.key});

  @override
  State<PatientAnswersPage> createState() => _PatienAnswersState();
}

class _PatienAnswersState extends State<PatientAnswersPage> {
  final _formKey = GlobalKey<FormState>();
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
                'Como você está se sentindo hoje?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              const AppRatingBar(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Qual sua temperatura agora?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    border: OutlineInputBorder(),
                    labelText: 'Temperatura °C',
                  ),
                  maxLength: 2,
                  controller: _temperatureCtrl,
                  onChanged: (value) => patientAnswares?.temperature =
                      int.parse(_temperatureCtrl.text),
                  validator: (value) {
                    final temperatura = value ?? '';
                    if (temperatura.trim().isEmpty) {
                      return 'Informe sua temperatura.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    patientAnswares?.temperature = int.parse(value!);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Está com dificuldade para respirar?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.difficultyBreathing,
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
                'Teve convulsão?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.convulsion,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Está com dor no corpo?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.bodyAche,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sente cansaço?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.tiredness,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Step(
          state:
              _activeStateIndex <= 2 ? StepState.disabled : StepState.complete,
          isActive: _activeStateIndex >= 2,
          title: const Text(''),
          content: Column(
            children: [
              Text(
                'Tem alguma ferida na boca?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.mouthSore,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sente dor ao engolir?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.painWhenSwallowing,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Teve algum episódio de vômito?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.vomit,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Step(
          isActive: _activeStateIndex >= 3,
          state: StepState.complete,
          title: const Text(''),
          content: Column(
            children: [
              Text(
                'Apresenta diarreia?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.diarrhea,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Percebe alguma mudança na pele?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.skinChange,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'A pele está quente ao toque?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.hotSkin,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tem sangramento ou hematoma?',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              AdaptativeCustomRadioButton(
                elevation: 5,
                padding: 0,
                height: 50,
                width: 150,
                enableShape: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                unSelectedColor: Theme.of(context).canvasColor,
                absoluteZeroSpacing: false,
                textStyle: Theme.of(context).textTheme.titleLarge!,
                buttonLables: const [
                  "Sim",
                  "Não",
                ],
                buttonValues: const [
                  "Sim",
                  "Não",
                ],
                radioButtonValue: patientAnswares!.bruise,
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

  @override
  Widget build(BuildContext context) {
    final isLastStep = _activeStateIndex == stepList().length - 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Acompanhamento clinico',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
      ),
      body: isCompleted
          ? Column(
              children: [
                Icon(
                  Icons.cloud_done,
                  color: Theme.of(context).colorScheme.primary,
                  size: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Respostas enviadas!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 8,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sair',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: _activeStateIndex,
                steps: stepList(),
                onStepContinue: () {
                  if (isLastStep) {
                    setState(() {
                      isCompleted = true;
                    });

                    print('complete');

                    // send data
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
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                isLastStep ? 'Confirmar' : 'Próximo',
                                style: Theme.of(context).textTheme.labelLarge,
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
                                backgroundColor: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                                elevation: 5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Voltar',
                                  style: Theme.of(context).textTheme.bodyMedium,
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
