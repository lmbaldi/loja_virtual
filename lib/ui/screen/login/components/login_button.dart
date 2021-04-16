import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';
import 'package:loja_virtual/ui/screen/components/components.dart';

class LoginButton extends StatefulWidget {
  GlobalKey<FormState> formKey;
  LoginButton(this.formKey);

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
      onPressed: (){
          if(widget.formKey.currentState.validate()){

          }
          setState(() {
            _showProgress = true;
          });

          setState(() {
            _showProgress = false;
          });
        },
    );
  }
}