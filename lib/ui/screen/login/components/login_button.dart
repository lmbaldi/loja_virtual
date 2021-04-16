import 'package:flutter/material.dart';
import 'package:loja_virtual/core/models/models.dart';
import 'package:loja_virtual/ui/components/app_button.dart';
import 'package:loja_virtual/ui/components/components.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController email;
  final TextEditingController password;

  LoginButton({
    @required this.formKey,
    @required this.email,
    @required this.password,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _showProgress = false;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      R.string.enter,
      showProgress: _showProgress,
      onPressed: () {
        setState(() {
          _showProgress = true;
        });

        if (widget.formKey.currentState.validate()) {
          context.read<UserManager>().signIn(
              user: User(
                email: widget.email.text,
                password: widget.password.text,
              ),
              onFail: (error) {
                showErrorMessage(context, error);
              },
              onSuccess: () {
                //TODO FECHAR TELA
              },
          );
        }

        setState(() {
          _showProgress = false;
        });
      },
    );
  }
}
