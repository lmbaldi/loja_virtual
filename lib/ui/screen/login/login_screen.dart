import 'package:flutter/material.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';
import 'package:loja_virtual/core/models/models.dart';
import 'package:provider/provider.dart';

import '../screen.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
            key: _formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child){
                return ListView(
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: EmailInput(controller: _email, enabled: !userManager.loading),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: PasswordInput(controller: _password, enabled: !userManager.loading),
                    ),
                    child,
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:  LoginButton(
                          formKey: _formKey, email: _email, password: _password),
                    ),
                    SizedBox(height: 25)
                  ],
                );
              },
              child:  Padding(
                padding: const EdgeInsets.all(4.0),
                child: ForgetPasswordFlatButton(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
