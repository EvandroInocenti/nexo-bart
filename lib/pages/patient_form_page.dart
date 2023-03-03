import 'package:flutter/material.dart';
import 'package:nexo_onco/components/adaptative_dropdown_button_form_field.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/patient_list.dart';
import '../components/adaptative_text_form_field.dart';
import '../models/tumor_list.dart';

class PatientFormPage extends StatefulWidget {
  PatientFormPage({
    super.key,
  });

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _cpfFocus = FocusNode();
  final _cellphoneFocus = FocusNode();
  final _birthDateFocus = FocusNode();
  final _heightFocus = FocusNode();
  final _weightFocus = FocusNode();
  final _bodySurfaceFocus = FocusNode();
  final _tumorFocus = FocusNode();
  final _stagingFocus = FocusNode();
  final _confirmedFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Patient get patient => ModalRoute.of(context)?.settings.arguments as Patient;

  @override
  void initState() {
    super.initState();
    Provider.of<TumorList>(context, listen: false).loadTumors();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (_formData.isEmpty) {
    //   final arg = ModalRoute.of(context)?.settings.arguments;

    //   if (arg != null) {
    //     final patient = arg as Patient;
    //     _formData['id'] = patient.id;
    //     _formData['name'] = patient.user!.name;
    //     _formData['email'] = patient.user!.email;
    //     _formData['cpf'] = patient.user!.cpf!;
    //     _formData['cellphone'] = patient.user!.telefone!;
    //     _formData['birthDate'] = patient.data_nascimento;
    //     _formData['height'] = patient.altura;
    //     _formData['weight'] = patient.peso;
    //     _formData['bodySurface'] = patient.superficie_corporea;
    //     _formData['tumor_id'] = patient.tumor_id!;
    //     _formData['staging'] = patient.staging;
    //     _formData['confirmed'] = patient.user!.confirmed!;
    //     _formData['tumor_id'] = patient.tumor_id!;
    //   }
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _cpfFocus.dispose();
    _cellphoneFocus.dispose();
    _birthDateFocus.dispose();
    _heightFocus.dispose();
    _weightFocus.dispose();
    _bodySurfaceFocus.dispose();
    _tumorFocus.dispose();
    _stagingFocus.dispose();
    _confirmedFocus.dispose();
  }

  Future<void> _submitForm() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<PatientList>(
        context,
        listen: false,
      ).savePatient(patient);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!',
              style: Theme.of(context).textTheme.titleLarge),
          content: Text('Ocorreu erro ao salvar o paciente.',
              style: Theme.of(context).textTheme.titleMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok', style: Theme.of(context).textTheme.titleMedium),
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
    final patient = ModalRoute.of(context)?.settings.arguments as Patient;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  AdaptativeTextFormField(
                    initialValue:
                        patient.user != null ? patient.user!.name : '',
                    keyboardType: TextInputType.name,
                    focusNode: _nameFocus,
                    label: 'Nome',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    onSaved: (name) => patient.user!.name = name ?? '',
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.trim().isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      if (name.trim().length < 3) {
                        return 'Nome necessita no mínimo 3 letras';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AdaptativeTextFormField(
                    initialValue:
                        patient.user != null ? patient.user!.email : '',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    label: 'E-mail',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cpfFocus);
                    },
                    onSaved: (email) => patient.user!.email = email ?? '',
                    validator: (_email) {
                      final email = _email ?? '';
                      if (email.trim().isEmpty) {
                        return 'E-mail é obrigatório';
                      }
                      if (!email.contains('@')) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue: patient.user!.cpf ?? '',
                          keyboardType: TextInputType.text,
                          focusNode: _cpfFocus,
                          label: 'CPF',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_cellphoneFocus);
                          },
                          onSaved: (cpf) => patient.user!.cpf = cpf,
                          validator: (_cpf) {
                            final cpf = _cpf ?? '';
                            if (cpf.trim().isEmpty) {
                              return 'CPF é obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue: patient.user!.telefone ?? '',
                          focusNode: _cellphoneFocus,
                          label: 'Celular',
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_birthDateFocus);
                          },
                          onSaved: (cellphone) =>
                              patient.user!.telefone = cellphone,
                          validator: (_cellphone) {
                            final cellphone = _cellphone ?? '';
                            if (cellphone.trim().isEmpty) {
                              return 'Celular é obrigatório';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue:
                              patient != null ? patient.data_nascimento : '',
                          focusNode: _birthDateFocus,
                          label: 'Data de Nascimento',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_heightFocus);
                          },
                          onSaved: (birthDate) =>
                              patient.data_nascimento = birthDate ?? '',
                          validator: (_birthDate) {
                            final birthDate = _birthDate ?? '';
                            if (birthDate.trim().isEmpty) {
                              return 'Data de nascimento não pode ser vazia';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue:
                              patient != null ? patient.altura.toString() : '',
                          focusNode: _heightFocus,
                          label: 'Altura',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_weightFocus);
                          },
                          keyboardType: TextInputType.number,
                          onSaved: (height) =>
                              patient.altura = int.parse(height ?? '0'),
                          validator: (_height) {
                            final heightString = _height ?? '0';
                            final height = int.tryParse(heightString) ?? -1;
                            if (height <= 0) {
                              return 'Informe uma altura válida';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue:
                              patient != null ? patient.peso.toString() : '',
                          focusNode: _weightFocus,
                          label: 'Peso',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_bodySurfaceFocus);
                          },
                          keyboardType: TextInputType.number,
                          onSaved: (weight) =>
                              patient.altura = int.parse(weight ?? '0'),
                          validator: (_weight) {
                            final weightString = _weight ?? '0';
                            final weight = int.tryParse(weightString) ?? -1;
                            if (weight <= 0) {
                              return 'Informe um peso válido';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AdaptativeTextFormField(
                          initialValue: patient != null
                              ? patient.superficie_corporea.toString()
                              : '',
                          focusNode: _bodySurfaceFocus,
                          label: 'Superfície Corpória',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_tumorFocus);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          onSaved: (bodySurface) =>
                              patient.superficie_corporea =
                                  double.parse(bodySurface ?? '0'),
                          validator: (_bodySurface) {
                            final bodySurfaceString = _bodySurface ?? '0';
                            final bodySurface =
                                double.tryParse(bodySurfaceString) ?? -1;
                            if (bodySurface <= 0) {
                              return 'Informe uma circunferência corpórea válida';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child:
                            Consumer<TumorList>(builder: (ctx, tumors, child) {
                          return AdaptativeDropdownButtonFormField(
                            label: 'Tumor',
                            value: patient.tumor!.name,
                            onChanged: (newValue) {
                              patient.tumor!.name = newValue;
                              patient.tumor_id = patient.tumor!.id;
                            },
                            items: tumors.items
                                .map<DropdownMenuItem<String>>((tumor) {
                              return DropdownMenuItem(
                                value: tumor.name,
                                child: Text(tumor.name!),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Estadiamento',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Slider(
                          focusNode: _stagingFocus,
                          label: patient != null
                              ? patient.staging.round().toInt().toString()
                              : '',
                          min: 1,
                          max: 4,
                          divisions: 3,
                          value: patient.staging.round().toDouble(),
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            setState(() {
                              patient.staging = value.toInt();
                              patient.sliderStaging(value.toInt());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Switch(
                          focusNode: _confirmedFocus,
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: patient.user!.confirmed!,
                          onChanged: (value) {
                            setState(() {
                              patient.user!.switchConfirmed(value);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text('Liberado',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            _formKey.currentState!.save();
                            _submitForm();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text("Salvar",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
