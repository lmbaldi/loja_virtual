import 'package:flutter/material.dart';
import 'package:loja_virtual/ui/helpers/i18n/resources.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: RaisedButton(
        onPressed: (){},
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(R.string.password),
      ),
    );
  }
}