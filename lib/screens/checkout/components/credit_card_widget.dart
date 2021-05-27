import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../../data/data.dart';
import '../../../helpers/helpers.dart';
import '../checkout.dart';

class CreditCardWidget extends StatefulWidget {
  final CreditCard creditCard;

  CreditCardWidget(this.creditCard);

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  //obs: alterado para Statefull para nao reiniciar todos os focusnode
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    final FocusNode numberFocus = FocusNode();
    final FocusNode dateFocus = FocusNode();
    final FocusNode nameFocus = FocusNode();
    final FocusNode cvvFocus = FocusNode();
    // final CreditCard creditCard = CreditCard();


    KeyboardActionsConfig _buildConfig(BuildContext context){
      return KeyboardActionsConfig(
          keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
          keyboardBarColor: Colors.grey[200],
          actions: [
            KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
            KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
            KeyboardActionsItem(
                focusNode: nameFocus,
                toolbarButtons: [
                      (_){
                    return GestureDetector(
                      onTap: (){
                        cardKey.currentState.toggleCard();
                        cvvFocus.requestFocus();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(R.string.done),
                      ),
                    );
                  }
                ]
            ),
          ]
      );
    }

    return KeyboardActions(
      config: _buildConfig(context),
      autoScroll: false,
      child: Padding(
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
                creditCard: widget.creditCard,
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: (){
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                creditCard: widget.creditCard,
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
      ),
    );
  }
}
