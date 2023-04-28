import 'package:flutter/material.dart';

import '../components/app_rating_bar.dart';

class PatientAnswersPage extends StatefulWidget {
  PatientAnswersPage({super.key});

  @override
  State<PatientAnswersPage> createState() => _PatienAnswersState();
}

class _PatienAnswersState extends State<PatientAnswersPage> {
  int _index = 0;
  final _temperatureCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // patientAnswersModel = PatientAnswersModel(
    //   temperature: int.tryParse(_temperatureCtrl.text) ?? 0,
    //   felling: _rating.toInt(),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _temperatureCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Acompanhamento'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              // physics: const ScrollPhysics(),
              type: StepperType.horizontal,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int newIndex) {
                setState(() {
                  _index = newIndex;
                });
              },
              steps: <Step>[
                Step(
                  state: _index <= 0 ? StepState.editing : StepState.complete,
                  isActive: _index >= 0,
                  title: Text(''),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          'Como você está se sentindo hoje?',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        AppRatingBar(),
                      ],
                    ),
                  ),
                ),
                Step(
                  state: _index <= 1 ? StepState.editing : StepState.complete,
                  isActive: _index >= 1,
                  title: Text(''),
                  content: Text('Step 2'),
                ),
                Step(
                  state: StepState.complete,
                  isActive: _index >= 2,
                  title: Text(''),
                  content: Text('Step 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
