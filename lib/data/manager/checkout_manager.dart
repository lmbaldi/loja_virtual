import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';
import '../../helpers/helpers.dart';
import '../../services/cielo_payment.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  final CieloPayment cieloPayment = CieloPayment();

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout(
      {CreditCard creditCard,
      Function onStockFail,
      Function onSuccess,
      Function onPayFail}) async {

    loading = true;
    final orderId = await _getOrderId();
    String payId;
    try {
      payId = await cieloPayment.authorize(
        creditCard: creditCard,
        price: cartManager.totalPrice,
        orderId: orderId.toString(),
        user: cartManager.user,
      ) as String;
      debugPrint('success $payId');
    } catch (e){
      onPayFail(e);
      loading = false;
      return;
    }

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    try {
      await cieloPayment.capture(payId);
    } catch (e){
      onPayFail(e);
      loading = false;
      return;
    }

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    order.payId = payId;
    await order.save();
    cartManager.clear();
    onSuccess(order);
    loading = false;
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
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(R.string.failedGenerateOrderNumber);
    }
  }

  Future<void> _decrementStock() async {
    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final cartProdutc in cartManager.items) {
        Product product;

        //verificar se o produto jah esta na lista  atualizada
        if (productsToUpdate.any((p) => p.id == cartProdutc.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProdutc.productId);
        } else {
          final doc = await tx
              .get(firestore.document('products/${cartProdutc.productId}'));
          product = Product.fromDocument(doc);
        }

        //obtem o estoque mais atualizado
        cartProdutc.product = product;

        final size = product.findSize(cartProdutc.size);

        //verifica se existe quantidade disponivel no estoque
        if (size.stock - cartProdutc.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProdutc.quantity;
          productsToUpdate.add(product);
        }
      }

      //verfica se a lista sem estoque nao esta vazia
      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} ${R.string.productsWithoutStock}');
      }

      //atualizar estoque dos produtos conforme os tamanhos
      for (final product in productsToUpdate) {
        tx.update(firestore.document('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
