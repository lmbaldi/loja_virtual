import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class ProductManager extends ChangeNotifier {

  ProductManager() {
    _loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;
  List<Product> _allProducts = [];

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
    _allProducts = snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();
    notifyListeners();
  }


}