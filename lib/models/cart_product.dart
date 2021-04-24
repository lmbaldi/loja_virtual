import 'models.dart';

class CartProduct {

  Product product;
  String productId;
  int quantity;
  String size;

  CartProduct.fromProduct(this.product){
    productId = productId;
    quantity = 1;
    size = product.selectedSize.name;
  }

  ItemSize get itemSize {
    if(product == null){
      return null;
    } else {
      return product.findSize(size);
    }
  }

  num get unitPrice {
    if(product == null){
      return 0;
    } else {
      return itemSize?.price ?? 0;
    }
  }

}