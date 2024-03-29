import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexo_onco/models/pending_response.dart';
import 'package:nexo_onco/models/pending_response_list.dart';
import 'package:nexo_onco/pages/patient_answers_weekly_page.dart';
import 'package:nexo_onco/pages/pending_responses_page.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/auth_list.dart';
import '../services/databaseController.dart';
import '../services/patient_notifications_service.dart';
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
          } else {
            var lastDate = snapshot.data?[0].lastAccess;
            DateTime newLastDate = DateTime.parse(lastDate);
            var dateNow = DateFormat("yyyy-MM-dd").format(DateTime.now());
            DateTime newDateNow = DateTime.parse(dateNow);
            bool? ansToday = snapshot.data?[1].ansToday ?? false;

            while ((newDateNow.isAfter(newLastDate)) ||
                (newDateNow.isAtSameMomentAs(newLastDate) &&
                    ansToday == false)) {
              if (newLastDate.weekday == DateTime.friday) {
                PendingResponseList().addPendingResponse(
                    'Reposta pendente',
                    DateFormat("yyyy-MM-dd").format(newLastDate),
                    'Semanal',
                    false);
                newLastDate = DateTime(
                    newLastDate.year, newLastDate.month, newLastDate.day + 1);
              }

              PendingResponseList().addPendingResponse('Reposta pendente',
                  DateFormat("yyyy-MM-dd").format(newLastDate), 'Diário', true);
              newLastDate = DateTime(
                  newLastDate.year, newLastDate.month, newLastDate.day + 1);
            }

            DatabaseController()
                .updateAuth(newDateNow, snapshot.data?[0].token);

            if (snapshot.data?[1].title != '') {
              return const PendingResponsesPage();
            } else {
              final moonLanding =
                  DateTime.parse(DateTime.now().toIso8601String());
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
