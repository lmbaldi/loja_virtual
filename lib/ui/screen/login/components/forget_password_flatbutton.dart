import 'package:flutter/material.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';

class ForgetPasswordFlatButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
          onPressed: (){},
          padding: EdgeInsets.zero,
          child: Text(R.string.forgetPassword)
      ),
    );
  }
}
