import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/screen/helpers/validators.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  EmailInput({this.controller});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: R.string.email),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (email){
        if(!emailValid(email)){
          return R.string.invalidEmail;
        }
        return null;
      },
    );
  }
}