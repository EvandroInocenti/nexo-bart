// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexo_onco/models/patient_notification.dart';
import 'package:nexo_onco/models/pending_response.dart';
import 'package:nexo_onco/models/pending_response_list.dart';
import 'package:nexo_onco/pages/patient_answers_weekly_page.dart';
import 'package:nexo_onco/pages/pending_responses_page.dart';
import 'package:nexo_onco/services/databaseController.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/auth_list.dart';
import '../services/patient_notifications_service.dart';
import '../utils/app_routes.dart';
import 'auth_page.dart';
import 'patient_answers_page.dart';
import 'patients_page.dart';

class AuthOrHomePage extends StatelessWidget {
  AuthOrHomePage({super.key});

  Future<Auth> init(BuildContext context) async {
    await Provider.of<PatientNotificationService>(
      context,
      listen: false,
    );
    // ignore: use_build_context_synchronously
    var providerAuth = await Provider.of<AuthList>(
      context,
      listen: false,
    ).getAuth();
    return providerAuth;
  }

  Future<PendingResponse> responses(BuildContext context) async {
    var providerResponse = await Provider.of<PendingResponseList>(
      context,
      listen: false,
    ).getPendingResponse();
    return providerResponse;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // inicializa o firebase
      future: Future.wait([init(context), responses(context)]),
      builder: (ctx, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          // carregar tokem salvo no BD
          if (snapshot.data?[0].token == null) {
            return AuthPage();
          }
          if (snapshot.data?[0].role != 'P') {
            return const PatientsPage();
            // Navigator.of(context).pushNamed(AppRoutes.patientForm);
          } else {
            if (snapshot.data?[0].lastAccess !=
                DateTime.now().toIso8601String()) {
              print('Ultimo acesso: ${snapshot.data?[0].lastAccess}');

              PendingResponseList().addPendingResponse('Reposta pendente',
                  snapshot.data?[0].lastAccess.toString(), 'Diário');

              // if (PendingResponseList().itemsCount > 0) {
              if (snapshot.data?[1].title != '') {
                return const PendingResponsesPage();
                // Navigator.of(context).pushNamed(AppRoutes.pendingResponsePage);
              }
            } else {
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
            }

            return PatientAnswersPage();
          }
        }
      },
    );
  }
}
