import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/patient_list.dart';
import '../components/adaptative_text_form_field.dart';

class PatientFormPage extends StatefulWidget {
  PatientFormPage(
    Patient patient, {
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
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final patient = arg as Patient;
        _formData['id'] = patient.id;
        _formData['name'] = patient.user!.name;
        _formData['email'] = patient.user!.email;
        _formData['cpf'] = patient.user!.cpf!;
        _formData['cellphone'] = patient.user!.telefone!;
        _formData['birthDate'] = patient.data_nascimento;
        _formData['height'] = patient.altura;
        _formData['weight'] = patient.peso;
        _formData['bodySurface'] = patient.superficie_corporea;
        _formData['tumor_id'] = patient.tumor_id!;
        _formData['staging'] = patient.staging;
        _formData['confirmed'] = patient.user!.confirmed!;
      }
    }
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
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);
    try {
      await Provider.of<PatientList>(
        context,
        listen: false,
      ).savePatient(_formData);

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
    final arg = ModalRoute.of(context)?.settings.arguments as Patient;

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
                  SizedBox(height: 10),
                  AdaptativeTextFormField(
                    initialValue: _formData['name']!.toString(),
                    keyboardType: TextInputType.name,
                    focusNode: _nameFocus,
                    label: 'Nome',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    onSaved: (name) => _formData['name'] = name ?? '',
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
                  SizedBox(height: 10),
                  AdaptativeTextFormField(
                    initialValue: _formData['email']!.toString(),
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    label: 'E-mail',
                    obscureText: false,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_cpfFocus);
                    },
                    onSaved: (email) => _formData['email'] = email ?? '',
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
                          initialValue: _formData['cpf']!.toString(),
                          keyboardType: TextInputType.text,
                          focusNode: _cpfFocus,
                          label: 'CPF',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_cellphoneFocus);
                          },
                          onSaved: (cpf) => _formData['cpf'] = cpf ?? '',
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
                          initialValue: _formData['cellphone']!.toString(),
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
                              _formData['cellphone'] = cellphone ?? '',
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
                          initialValue: _formData['birthDate']!.toString(),
                          focusNode: _birthDateFocus,
                          label: 'Data de Nascimento',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_heightFocus);
                          },
                          onSaved: (birthDate) =>
                              _formData['birthDate'] = birthDate ?? '',
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
                          initialValue: _formData['height']!.toString(),
                          focusNode: _heightFocus,
                          label: 'Altura',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_weightFocus);
                          },
                          keyboardType: TextInputType.number,
                          onSaved: (height) =>
                              _formData['height'] = int.parse(height ?? '0'),
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
                          initialValue: _formData['weight']!.toString(),
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
                              _formData['weight'] = int.parse(weight ?? '0'),
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
                          initialValue: _formData['bodySurface']!.toString(),
                          focusNode: _bodySurfaceFocus,
                          label: 'Circunferência Corpória',
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_tumorFocus);
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          onSaved: (bodySurface) => _formData['bodySurface'] =
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
                        child: AdaptativeTextFormField(
                          initialValue: _formData['tumor_id']!.toString(),
                          focusNode: _tumorFocus,
                          label: 'Tumor',
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          onSaved: (tumor) =>
                              _formData['tumor_id'] = int.parse(tumor ?? '0'),
                          validator: (_tumor) {
                            final tumorString = _tumor ?? '0';
                            final tumor = double.tryParse(tumorString) ?? -1;
                            if (tumor <= 0) {
                              return 'Selecione um tumor';
                            }

                            return null;
                          },
                        ),
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
                          label: arg != null
                              ? arg.staging.round().toInt().toString()
                              : _formData['staging'].toString(),
                          min: 1,
                          max: 4,
                          divisions: 3,
                          value: arg.staging.round().toDouble(),
                          // value: _formData['staging'] as double,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            setState(() {
                              _formData['staging'] = value.toInt();
                              arg.staging = value.toInt();
                              arg.sliderStaging(value.toInt());
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
                          value: arg.user!.confirmed!,
                          onChanged: (value) {
                            setState(() {
                              _formData['confirmed'] = value;
                              arg.user!.switchConfirmed(value);
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
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  "Salvar",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
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
