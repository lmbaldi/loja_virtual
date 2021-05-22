import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CardFront extends StatelessWidget {

  final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
          height: 200,
          color: const Color(0xFF1B4B52),
          padding: const EdgeInsets.all(24),
          child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CardTextField(
                          title: R.string.labelTextNumber,
                          hint: '0000 0000 0000 0000',
                          textInputType: TextInputType.number,
                          bold: true,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CartaoBancarioInputFormatter(),
                          ],
                        ),
                        CardTextField(
                          title: R.string.labelTextExpirationDate,
                          hint: '11/2025',
                          textInputType: TextInputType.number,
                          bold: true,
                          inputFormatters: [dateFormatter],
                        ),
                        CardTextField(
                          title: R.string.labelTextNameOnCard,
                          hint: 'John Smith',
                          textInputType: TextInputType.text,
                          bold: true,
                        ),
                      ]
                  ),
                ),
              ]
          )
      ),
    );
  }
}
