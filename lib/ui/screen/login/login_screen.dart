import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

import '../screen.dart';

class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.enter),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: EmailInput(controller: emailController),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PasswordInput(controller: passwordController),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ForgetPasswordFlatButton(),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: LoginButton(formKey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}







