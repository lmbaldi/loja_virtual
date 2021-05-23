import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:loja_virtual/screens/checkout/checkout.dart';

class CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    color: Colors.grey[500],
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CardTextField(
                      hint: '123',
                      maxLength: 3,
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      validator: (cvv){
                        if(cvv.length != 3) return R.string.invalid;
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}