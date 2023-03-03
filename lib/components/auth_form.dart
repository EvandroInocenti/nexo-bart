import 'package:flutter/material.dart';
import 'package:nexo_onco/components/adaptative_text_form_field.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Ocorreu um erro',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(),
              setState(() => _isLoading = false),
            },
            child: Text(
              'Fechar',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formkey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);

    _formkey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    try {
      await auth.login(_authData['email']!, _authData['password']!);
    } catch (error) {
      _showErrorDialog(error.toString());
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        width: deviceSize.width * 0.80,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              AdaptativeTextFormField(
                initialValue: '',
                label: 'E-mail',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AdaptativeTextFormField(
                initialValue: '',
                label: 'Senha',
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.trim().isEmpty || password.length < 8) {
                    return 'Informe uma senha válida.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8)),
                  child: Text(
                    'Entrar',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
