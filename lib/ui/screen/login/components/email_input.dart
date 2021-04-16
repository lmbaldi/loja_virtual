import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/screen/components/app_text_input.dart';
import 'package:loja_virtual/ui/screen/helpers/validators.dart';

class EmailInput extends StatelessWidget {

  final TextEditingController controller;
  final _focusSenha = FocusNode();

  EmailInput({this.controller});

  @override
  Widget build(BuildContext context) {
       return AppTextInput(
        R.string.email,
        R.string.typeLoginEmail,
        controller: controller,
        focusNode: _focusSenha,
        validator: (email){
          if (!emailValid(email)) {
          return R.string.invalidEmail;
        }
        return null;
      },
    );
  }
}