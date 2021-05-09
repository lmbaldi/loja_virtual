import 'package:flutter/material.dart';
import 'package:loja_virtual/data/data.dart';

class CheckoutManager extends ChangeNotifier{

  CartManager cartManager;

  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
    print('cartmanager => ${cartManager.productsPrice}');
  }
}