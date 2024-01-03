import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexo_onco/models/patient_answers.dart';
import 'package:nexo_onco/models/patient_answers_list.dart';
import 'package:provider/provider.dart';

import '../components/adaptative_rating_bar.dart';
import '../models/auth.dart';
import '../models/patient.dart';
import '../models/patient_list.dart';
import '../models/pending_response_list.dart';
import '../utils/app_routes.dart';

class PatientAnswersPage extends StatefulWidget {
  PatientAnswersPage({
    super.key,
  });

  @override
  State<PatientAnswersPage> createState() => _PatienAnswersState();
}

class _PatienAnswersState extends State<PatientAnswersPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  double _rating = -1;
  int _activeStateIndex = 0;
  bool isCompleted = false;
  PatientAnswers? patientAnswares;
  final _temperatureCtrl = TextEditingController();
  Patient? patient;

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
              AdaptativeRatingBar(
                initialRating: _rating,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                itemSize: 60,
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                    patientAnswares!.felling = _rating.toInt();
                  });
                },
                updateOnDrag: true,
                itemCount: 5,
                direction: Axis.horizontal,
              ),
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
                child: GestureDetector(
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
                'Está com dificuldade para respirar?',
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
                  value == 'Não'
                      ? patientAnswares!.difficulty_breathing = false
                      : patientAnswares!.difficulty_breathing = true;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Teve convulsão?',
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
                'Está com dor no corpo?',
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
                radioButtonValue: (value) =>
                    patientAnswares!.body_ache = value == "Sim" ? true : false,
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
                radioButtonValue: (value) =>
                    patientAnswares!.tiredness = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tem alguma ferida na boca?',
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
                radioButtonValue: (value) =>
                    patientAnswares!.mouth_sore = value == "Sim" ? true : false,
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
                'Sente dor ao engolir?',
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
                radioButtonValue: (value) => patientAnswares!
                    .pain_when_swallowing = value == "Sim" ? true : false,
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
                radioButtonValue: (value) =>
                    patientAnswares!.vomit = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Apresenta diarreia?',
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
                radioButtonValue: (value) =>
                    patientAnswares!.diarrhea = value == "Sim" ? true : false,
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
                'Percebe alguma mudança na pele?',
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
                radioButtonValue: (value) => patientAnswares!.skin_change =
                    value == "Sim" ? true : false,
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
                radioButtonValue: (value) =>
                    patientAnswares!.hot_skin = value == "Sim" ? true : false,
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
                radioButtonValue: (value) =>
                    patientAnswares!.bruise = value == "Sim" ? true : false,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        //   if (patient!.surgery)
        //     Step(
        //       isActive: _activeStateIndex >= 4,
        //       state: StepState.complete,
        //       title: const Text(''),
        //       content: Column(
        //         children: [
        //           Text(
        //             'Sente dor na ferida?',
        //             textAlign: TextAlign.start,
        //             style: Theme.of(context).textTheme.titleLarge,
        //           ),
        //           const SizedBox(
        //             height: 5,
        //           ),
        //           CustomRadioButton(
        //             elevation: 5,
        //             padding: 0,
        //             height: 50,
        //             width: 150,
        //             enableShape: true,
        //             shapeRadius: 10,
        //             selectedColor: Theme.of(context).colorScheme.primary,
        //             unSelectedColor: Theme.of(context).canvasColor,
        //             selectedBorderColor: Colors.transparent,
        //             unSelectedBorderColor: Colors.transparent,
        //             absoluteZeroSpacing: false,
        //             buttonTextStyle: ButtonTextStyle(
        //               selectedColor: Colors.white,
        //               unSelectedColor: Colors.black,
        //               textStyle: Theme.of(context).textTheme.titleLarge!,
        //             ),
        //             buttonLables: const [
        //               "Sim",
        //               "Não",
        //             ],
        //             buttonValues: const [
        //               "Sim",
        //               "Não",
        //             ],
        //             radioButtonValue: (value) =>
        //                 patient?.surgery_pain = value == "Sim" ? true : false,
        //           ),
        //           const SizedBox(
        //             height: 20,
        //           ),
        //         ],
        //       ),
        //     )
      ];

  @override
  void initState() {
    super.initState();
    Provider.of<PatientList>(context, listen: false).loadPatients();
    patientAnswares = PatientAnswers(
      temperature: int.tryParse(_temperatureCtrl.text) ?? 0,
      difficulty_breathing: false,
      body_ache: false,
      bruise: false,
      convulsion: false,
      diarrhea: false,
      hot_skin: false,
      mouth_sore: false,
      pain_when_swallowing: false,
      skin_change: false,
      tiredness: false,
      vomit: false,
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
          title: Text('Ocorreu um erro! $error',
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
          'Acompanhamento clínico diário',
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
                      snapshot.data! > 0
                          ? Container(
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
                                child: Text(
                                  'Voltar',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                    AppRoutes.pendingResponsePage,
                                  );
                                },
                              ),
                            )
                          : Container(
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
                                child: Text(
                                  'Sair',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (patientAnswares!.temperature! > 37.5 ||
                                        patientAnswares!.convulsion! ||
                                        patientAnswares!.difficulty_breathing!)
                                    ? Container(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
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
                                        ),
                                      )
                                    : Text(
                                        '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                              ],
                            ),
                          ],
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
