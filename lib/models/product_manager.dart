import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class ProductManager extends ChangeNotifier {

  ProductManager() {
    loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];

  Future<void> loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
    allProducts = snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();
    notifyListeners();
  }


}