import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/models.dart';

class Product {
  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  Product.fromDocument( DocumentSnapshot document ){
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.data['images']) as List<dynamic>;
    sizes = (document.data['sizes'] as List<dynamic> ?? []).map((s) => ItemSize.fromMap(s)).toList();

  }

}