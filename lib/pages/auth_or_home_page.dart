// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexo_onco/pages/patient_answers_weekly_page.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/auth_list.dart';
import '../services/patient_notifications_service.dart';
import 'auth_page.dart';
import 'patient_answers_page.dart';
import 'patients_page.dart';

class AuthOrHomePage extends StatelessWidget {
  AuthOrHomePage({super.key});

  var _itemCount;

  Future<void> init(BuildContext context) async {
    await Provider.of<PatientNotificationService>(
      context,
      listen: false,
    );
    _itemCount = await Auth().itemsCount();
    //   await Provider.of<AuthList>(
    //     context,
    //     listen: false,
    //   ).loadAuths();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      // inicializa o firebase
      future: Future.wait([init(context)]),
      builder: (ctx, AsyncSnapshot snapshot) {
        // carregar tokem salvo no BD
        _itemCount == null ? 0 : _itemCount;
        if (_itemCount < 1) {
          return AuthPage();
        }
        if (auth.role == 'P') {
          final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
          if (kDebugMode) {
            print(moonLanding.weekday);
          } //  7
          if (kDebugMode) {
            print(DateTime.sunday);
          }
          if (moonLanding.weekday == DateTime.friday) {
            // if (moonLanding.weekday == DateTime.sunday) {
            return PatientWeeklyAnswersPage();
          }
          return PatientAnswersPage();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return const PatientsPage();
      },
    );
  }
}
