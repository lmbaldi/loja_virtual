import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import '../../data/data.dart';

class CancelOrderDialog extends StatelessWidget {

  final Order order;

  CancelOrderDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${R.string.cancel} ${order.formattedId}?'),
      content: Text(R.string.msgCancelOrderDialog),
      actions: [
        FlatButton(
            onPressed: (){
              order.cancel();
              Navigator.of(context).pop();
            },
            color: Colors.red,
            child: Text(R.string.cancelOrder)
        )
      ],
    );
  }
}
