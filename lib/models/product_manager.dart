import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class ProductManager extends ChangeNotifier {

  ProductManager() {
    loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;
  List<Product> allProducts = [];
  String _search = '';

  set search(String value){
    _search = value;
    notifyListeners();
  }

  String get search => _search;

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where((p) => p.name.toLowerCase().contains(search.toLowerCase()))
      );
    }
    return filteredProducts;
  }

  Future<void> loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();
    allProducts = snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();
    notifyListeners();
  }


}