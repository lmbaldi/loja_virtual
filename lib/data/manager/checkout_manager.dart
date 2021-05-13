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

  Future<void> checkout({Function onStockFail}) async {
    try{
      await _decrementStock();
    }catch(e){
      onStockFail(e);
      debugPrint(e.toString());
      return;
    }
    //PROCESSAR PAGAMENTO

    final orderId = await _getOrderId();
    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    await order.save();
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

  Future<void> _decrementStock() async {
    return firestore.runTransaction((tx) async {

      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for( final cartProdutc in cartManager.items){
        Product product;

        //verificar se o produto jah esta na lista  atualizada
        if(productsToUpdate.any((p) => p.id == cartProdutc.productId)){
          product = productsToUpdate.firstWhere((p) => p.id == cartProdutc.productId);
        }else {
         final doc = await tx.get(firestore.document('products/${cartProdutc.productId}'));
         product = Product.fromDocument(doc);
        }

        //obtem o estoque mais atualizado
        cartProdutc.product = product;

       final size = product.findSize(cartProdutc.size);

       //verifica se existe quantidade disponivel no estoque
       if(size.stock - cartProdutc.quantity < 0){
          productsWithoutStock.add(product);
       }else{
        size.stock -= cartProdutc.quantity;
        productsToUpdate.add(product);
       }
      }

      //verfica se a lista sem estoque nao esta vazia
      if(productsWithoutStock.isNotEmpty){
        return Future.error('${productsWithoutStock.length} ${R.string.productsWithoutStock}');
      }

      //atualizar estoque dos produtos conforme os tamanhos
      for(final product in productsToUpdate){
        tx.update(firestore.document('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }

    });
  }

}