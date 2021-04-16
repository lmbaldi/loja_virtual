import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/screen/components/app_text_input.dart';

class PasswordInput extends StatelessWidget {

  TextEditingController controller;

  PasswordInput({this.controller});

  @override
  Widget build(BuildContext context) {
     return AppTextInput(
       R.string.password,
       R.string.typePassword,
       controller: controller,
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