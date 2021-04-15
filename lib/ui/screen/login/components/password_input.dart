import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class PasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(hintText: R.string.password),
      autocorrect: false,
      obscureText: true,
      validator: (senha){
        return null;
      },
    );
  }
}