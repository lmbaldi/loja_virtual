import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: R.string.email),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      validator: (email){
        return null;
      },
    );
  }
}