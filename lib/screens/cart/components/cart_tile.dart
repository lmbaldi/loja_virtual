import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';
import 'package:loja_virtual/models/models.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(cartProduct.product.images.first),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Text(
                      cartProduct.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'R.string.size : ${cartProduct.size}',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    Text(
                      'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
