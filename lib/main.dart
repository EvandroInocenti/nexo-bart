import 'package:flutter/material.dart';
import 'package:nexo_onco/models/treatment_patient_list.dart';
import 'package:nexo_onco/models/tumor_list.dart';
import 'package:nexo_onco/pages/implanted_catheter_page.dart';
import 'package:nexo_onco/pages/oncological_cirurgian_page.dart';
import 'package:nexo_onco/pages/patient_form_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/auth.dart';
import 'models/cicle_list.dart';
import 'models/drugs_list.dart';
import 'models/environment.dart';
import 'models/patient_list.dart';
import 'models/treatment_list.dart';
import 'pages/auth_or_home_page.dart';
import 'pages/radiotherapy_page.dart';
import 'pages/tabs_page.dart';
import 'utils/app_routes.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PatientList>(
          create: (_) => PatientList('', []),
          update: (ctx, auth, previous) {
            return PatientList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, TumorList>(
          create: (_) => TumorList('', []),
          update: (ctx, auth, previous) {
            return TumorList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, TreatmentPatientList>(
          create: (_) => TreatmentPatientList('', []),
          update: (ctx, auth, previous) {
            return TreatmentPatientList(
                auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, TreatmentList>(
          create: (_) => TreatmentList('', []),
          update: (ctx, auth, previous) {
            return TreatmentList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, DrugList>(
          create: (_) => DrugList('', []),
          update: (ctx, auth, previous) {
            return DrugList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, CicleList>(
          create: (_) => CicleList('', []),
          update: (ctx, auth, previous) {
            return CicleList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(
          create: (_) => TabsPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nexo Onco',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: const Color.fromARGB(255, 10, 83, 148),
            secondary: const Color.fromARGB(255, 244, 153, 55),
          ),
          textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleMedium: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 18,
              color: Colors.black,
            ),
            titleSmall: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 14,
              color: Colors.grey,
            ),
            labelLarge: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: const TextStyle(
              fontFamily: 'Mulish',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        routes: {
          AppRoutes.authOrHome: (ctx) => AuthOrHomePage(),
          AppRoutes.tabsPage: (ctx) => TabsPage(),
          AppRoutes.patientForm: (ctx) => PatientFormPage(),
          AppRoutes.oncologicalForm: (ctx) => OncologicalCirurgianPage(),
          AppRoutes.catheterForm: (ctx) => ImplantedCatheterPage(),
          AppRoutes.radiotherapyForm: (ctx) => RadiotherapyPage(),
        },
      ),
    );
  }
}
