import 'package:flutter/material.dart';
import 'package:nexo_onco/pages/implanted_catheter_page.dart';
import 'package:nexo_onco/pages/oncological_cirurgian_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/environment.dart';
import 'models/patient_list.dart';
import 'pages/patients_page.dart';
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
          create: (_) => PatientList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nexo Onco',
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: const Color(0xFF0a5394),
            secondary: const Color(0xFFf49937),
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
          AppRoutes.home: (ctx) => PatientsPage(),
          AppRoutes.tabsPage: (ctx) => TabsPage(),
          AppRoutes.oncologicalForm: (ctx) => OncologicalCirurgianPage(),
          AppRoutes.catheterForm: (ctx) => ImplantedCatheterPage(),
        },
      ),
    );
  }
}
