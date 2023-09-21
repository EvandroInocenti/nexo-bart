import 'package:flutter/material.dart';
import 'implanted_catheter_page.dart';
import 'patient_form_page.dart';
import 'radiotherapy_page.dart';

// ignore: must_be_immutable
class TabsPage extends StatefulWidget with ChangeNotifier {
  TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedPageIndex = 0;

  final List<Map<String, Object>> _pages = [
    {'title': 'Informações do Paciente', 'page': PatientFormPage()},
    // {'title': 'Cirurgia Oncológica', 'page': OncologicalCirurgianPage()},
    // {'title': 'Catéter', 'page': ImplantedCatheterPage()},
    {'title': 'Radioterapia', 'page': RadiotherapyPage()},
  ];

  @override
  void initState() {
    super.initState();
  }

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Provider.of<PatientList>(
              //   context,
              //   listen: false,
              // ).savePatient();
            },
            icon: Icon(
              Icons.save,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.person_rounded),
            label: 'Geral',
          ),
          // BottomNavigationBarItem(
          //   backgroundColor: Theme.of(context).colorScheme.primary,
          //   icon: const Icon(Icons.medical_services_rounded),
          //   label: 'Cirurgia Oncológica',
          // ),
          // Bottom
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.medication_rounded),
            label: 'Radioterapia',
          ),
        ],
      ),
    );
  }
}
