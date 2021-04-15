import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class PasswordInput extends StatelessWidget {

  TextEditingController controller;

  PasswordInput({this.controller});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(hintText: R.string.password),
      autocorrect: false,
      obscureText: true,
      validator: (password){
        if(password.isEmpty || password.length < 6){
          return R.string.invalidPassword;
        }
        return null;
      },
    );
  }
}