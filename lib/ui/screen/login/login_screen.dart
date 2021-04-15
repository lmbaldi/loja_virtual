import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

import '../screen.dart';

class LoginScreen extends StatelessWidget {
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
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: EmailInput(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: PasswordInput(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ForgetPasswordFlatButton(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: LoginButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}







