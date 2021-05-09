import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/common.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
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

          if(cartManager.user == null){
            return LoginCard();
          }

          if(cartManager.items.isEmpty){
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: R.string.noProductsCart,
            );
          }

          return ListView(
            children: [
              Column(
                children: cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
              ),
              PriceCard(
                buttonText: R.string.continueForDelivery,
                onPressed: cartManager.isCartValid
                ? (){
                      Navigator.of(context).pushNamed('/address');
                    }
                : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
