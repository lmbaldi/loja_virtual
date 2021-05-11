import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/data.dart';
import 'package:loja_virtual/helpers/helpers.dart';

class CheckoutManager extends ChangeNotifier{

  CartManager cartManager;

  final Firestore firestore = Firestore.instance;

  void updateCart(CartManager cartManager){
    this.cartManager = cartManager;
    print('cartmanager => ${cartManager.productsPrice}');
  }

  void checkout(){
    _decrementStock();

  }

  Future<int> _getOrderId() async {
    final ref = firestore.document('aux/ordercounter');
    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'] as int;
    } catch (e){
      debugPrint(e.toString());
      return Future.error(R.string.failedGenerateOrderNumber);
    }
  }

  void _decrementStock() {
    //
  }

}