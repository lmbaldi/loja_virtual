import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class CartManager {

  List<CartProduct> items = [];
  User user;

  updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    //carrega o carrinho para o novo usuario logado
    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }

}