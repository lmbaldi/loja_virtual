import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';

import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CardFront extends StatelessWidget {

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finished;

  CardFront({this.numberFocus, this.dateFocus, this.nameFocus, this.finished});

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
                          validator: (number){
                            if(number?.length != 19) return R.string.invalid;
                            else if(detectCCType(number) == CreditCardType.unknown)
                              return R.string.invalid;
                            return null;
                          },
                          onSubmitted: (_){
                            dateFocus.requestFocus();
                          },
                          focusNode: numberFocus,
                        ),
                        CardTextField(
                          title: R.string.labelTextExpirationDate,
                          hint: '11/2025',
                          textInputType: TextInputType.number,
                          bold: true,
                          inputFormatters: [dateFormatter],
                          validator: (date){
                            if(date?.length != 7) return R.string.invalid;
                            return null;
                          },
                          onSubmitted: (_){
                            nameFocus.requestFocus();
                          },
                          focusNode: dateFocus,
                        ),
                        CardTextField(
                          title: R.string.labelTextNameOnCard,
                          hint: 'John Smith',
                          textInputType: TextInputType.text,
                          bold: true,
                          validator: (name){
                            if(name == null) return R.string.invalid;
                            return null;
                          },
                          onSubmitted: (_){
                            finished();
                          },
                          focusNode: nameFocus,
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
