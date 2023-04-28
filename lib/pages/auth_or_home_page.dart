import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import 'auth_page.dart';
import 'patient_answers_page.dart';
import 'patients_page.dart';

class AuthOrHomePage extends StatelessWidget {
  AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    if (auth.isAuth) {
      if (auth.role == 'P') {
        return PatientAnswersPage();
      } else {
        return PatientsPage();
      }
    } else {
      return AuthPage();
    }
  }
}
