import 'models.dart';

class CartManager {

  List<CartProduct> items = [];

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }
}