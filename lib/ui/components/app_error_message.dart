import 'package:flutter/material.dart';
import 'package:loja_virtual/core/helpers/i18n/resources.dart';

void showErrorMessage(BuildContext context, String error) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[900],
      content: Text(
          R.string.errorLogin + error,
          textAlign: TextAlign.center,
      ),
    ),
  );
}
