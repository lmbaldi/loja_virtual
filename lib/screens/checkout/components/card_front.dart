import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:loja_virtual/screens/checkout/checkout.dart';

class CardFront extends StatelessWidget {
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
                        ),
                        CardTextField(
                          title: R.string.labelTextExpirationDate,
                          hint: '11/2025',
                          textInputType: TextInputType.text,
                          bold: true,
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
