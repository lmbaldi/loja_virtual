import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class CartManager extends ChangeNotifier{
  List<CartProduct> items = [];
  User user;

  updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    //carrega o carrinho para o novo usuario logado
    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      //verifica se os produtos sao iguais para conta-los
      final produtosIguais = items.firstWhere((p) => p.stackable(product));
      //incrementa a quantidade
      produtosIguais.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      notifyListeners();
    }
  }

  void _onItemUpdated() {
    for (final cartProduct in items) {
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
      }
      _updateCartProduct(cartProduct);
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    user.cartReference
        .document(cartProduct.id)
        .updateData(cartProduct.toCartItemMap());
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    //remove o item no firebase
    user.cartReference.document(cartProduct.id).delete();
    //remove o listener do cartProduct porque ele nao vai mais ser utilizado
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }
}
