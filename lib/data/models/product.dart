import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  ItemSize _selectedSize;

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images']) as List<dynamic>;
    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  ItemSize get selectedSize => _selectedSize;

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }
}