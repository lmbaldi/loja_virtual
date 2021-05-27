import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/data.dart';
import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CardBack extends StatelessWidget {

  final FocusNode cvvFocus;
  final CreditCard creditCard;

  CardBack({this.cvvFocus, this.creditCard});

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
                      initialValue: creditCard.securityCode,
                      hint: '123',
                      maxLength: 3,
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      validator: (cvv){
                        if(cvv == null || cvv.length != 3) return R.string.invalid;
                        return null;
                      },
                      focusNode: cvvFocus,
                      onSaved: creditCard.setCVV,
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
