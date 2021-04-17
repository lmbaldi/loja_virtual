import 'package:flutter/material.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/components/app_text_input.dart';
import 'package:loja_virtual/ui/screen/helpers/validators.dart';

class EmailInput extends StatelessWidget {

  final TextEditingController controller;
  final _focusSenha = FocusNode();
  bool enabled;

  EmailInput({this.controller, this.enabled});

  @override
  Widget build(BuildContext context) {
       return AppTextInput(
        R.string.email,
        R.string.typeLoginEmail,
        controller: controller,
        focusNode: _focusSenha,
        enabled: enabled,
        validator: (email){
          if (!emailValid(email)) {
          return R.string.invalidEmail;
        }
        return null;
      },
    );
  }
}