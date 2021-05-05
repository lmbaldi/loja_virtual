import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../helpers/helpers.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: R.string.zipCode,
            hintText: R.string.zipCodeHintText
          ),
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
        ),
        RaisedButton(
          onPressed: (){},
          textColor: Colors.white,
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          child: Text('Buscar CEP'),
        ),
      ],
    );
  }
}
