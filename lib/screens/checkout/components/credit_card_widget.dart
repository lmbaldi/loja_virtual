import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CreditCardWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

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
            front: CardFront(),
            back: CardBack(),
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
