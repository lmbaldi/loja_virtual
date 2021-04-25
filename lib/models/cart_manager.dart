import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class CartManager {
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
      produtosIguais.quantity++;
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference.add(cartProduct.toCartItemMap());
    }
  }

  void _onItemUpdated() {
    
  }
}
