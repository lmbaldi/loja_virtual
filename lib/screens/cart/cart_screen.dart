import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import 'cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.cart),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __){
          return Column(
            children: cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
          );
        },
      ),
    );
  }
}
