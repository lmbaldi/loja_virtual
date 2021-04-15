import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class LoginButton extends StatelessWidget {
  GlobalKey<FormState> formKey;
  LoginButton(this.formKey);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: RaisedButton(
        onPressed: (){
          if(formKey.currentState.validate()){}
        },
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(R.string.enter),
      ),
    );
  }
}