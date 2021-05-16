import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import '../../data/data.dart';
import '../common.dart';

class OrderTile extends StatelessWidget {

  final Order order;
  final bool showControls;

  const OrderTile(this.order, {this.showControls = false});


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          Text(
            order.statusText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: order.status == Status.canceled ? Colors.red : primaryColor,
            ),
          ),
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e){
              return OrderProductTile(e);
            }).toList(),
          ),
          if(showControls && order.status != Status.canceled)
          SizedBox(height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => CancelOrderDialog(order)
                    );
                  },
                  textColor: Colors.red,
                  child: Text(R.string.cancel),
                ),
                FlatButton(
                  onPressed: order.back,
                  child: Text(R.string.backOff),
                ),
                FlatButton(
                  onPressed: order.advance,
                  child: Text(R.string.advance),
                ),
                FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => ExportAddressDialog(order.address)
                    );
                  },
                  child: Text(R.string.address),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}