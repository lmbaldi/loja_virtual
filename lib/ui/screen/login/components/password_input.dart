import 'package:flutter/material.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/components/app_text_input.dart';

class PasswordInput extends StatelessWidget {

  TextEditingController controller;
  bool enabled;

  PasswordInput({this.controller, this.enabled});

  @override
  Widget build(BuildContext context) {
     return AppTextInput(
       R.string.password,
       R.string.typePassword,
       controller: controller,
       enabled: enabled,
       password: true,
         validator: (pass){
           if(pass.isEmpty || pass.length < 6){
             return R.string.invalidPassword;
           }
           return null;
         },
     );
  }
}