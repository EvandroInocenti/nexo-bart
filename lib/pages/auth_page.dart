import 'package:flutter/material.dart';

import '../components/auth_form.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 244, 153, 55),
                  Color.fromARGB(255, 10, 83, 148),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Image.asset('assets/images/marca_principal.png'),
                      ),
                    ),
                    AuthForm(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
