import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CreditCardWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    final FocusNode numberFocus = FocusNode();
    final FocusNode dateFocus = FocusNode();
    final FocusNode nameFocus = FocusNode();
    final FocusNode cvvFocus = FocusNode();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            flipOnTouch: false,
            front: CardFront(
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: (){
                cardKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              cvvFocus: cvvFocus,
            ),
          ),
          FlatButton(
            onPressed: (){
              cardKey.currentState.toggleCard();
            },
            textColor: Colors.white,
            padding: EdgeInsets.zero,
            child:  Text(R.string.flipCard),
          )
        ],
      ),
    );
  }
}
