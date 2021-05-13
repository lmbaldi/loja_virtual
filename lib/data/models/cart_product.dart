import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'models.dart';

class CartProduct extends ChangeNotifier {
  Product _product;
  String id;
  String productId;
  int quantity;
  String size;

  final Firestore firestore = Firestore.instance;

  CartProduct.fromProduct(this._product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('products/$productId').get().then((doc) {
      product = Product?.fromDocument(doc) ;
    });
  }
  Product get product => _product;
  set product(Product value){
    _product = value;
    notifyListeners();
  }

  ItemSize get itemSize {
    if (product == null) {
      return null;
    } else {
      return product.findSize(size);
    }
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) {
      return false;
    } else {
      return size.stock >= quantity;
    }
  }

  num get unitPrice {
    if (product == null) {
      return 0;
    } else {
      return itemSize?.price ?? 0;
    }
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,

    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }


  @override
  String toString() {
    return 'CartProduct{product: $product, id: $id, productId: $productId, quantity: $quantity, size: $size, firestore: $firestore}';
  }

}
