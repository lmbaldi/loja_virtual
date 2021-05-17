import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';
import 'models.dart';

class Product extends ChangeNotifier {

  String id;
  String name;
  String description;
  List<String> images = [];
  List<ItemSize> sizes;
  bool deleted;

  Product();

  Product.fromObject({this.id, this.name, this.description, this.images, this.sizes, this.deleted = false}){
    images  = images ?? [];
    sizes = sizes ?? [];

  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images  = List<String>.from(document.data['images'] as List<dynamic>) ;
    deleted = (document.data['deleted'] ?? false ) as bool;
    sizes = (document.data['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  List<dynamic> newImages;
  ItemSize _selectedSize;
  bool _loading = false;

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRef => storage.ref().child('products').child(id);

  set loading (bool value){
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  num get basePrice {
    num lowest = double.infinity;
    for(final size in sizes){
      if(size.price < lowest && size.hasStock){
        lowest = size.price;
      }
    }
    return lowest;
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

  List<Map<String, dynamic>> exportSizeList(){
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {

    loading = true;

    final List<String> updateImages = [];
    
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'deleted': deleted
    };
    //salvando produto
    await salvarProduto(data);
    //adicionando imagens do produto
    await adicionarImagens(updateImages);
    //removendo imagens  do produto  no storage
    await removerImagens();
    //atualizar imagens
    await atualizarImagens(updateImages);

    loading = false;
  }

  Future salvarProduto(Map<String, dynamic> data) async {
    if(id == null){
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }
  }

  Future adicionarImagens(List<String> updateImages) async {
    for(final newImage in newImages){
      if(images.contains(newImage)){
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task =  storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }
  }

  Future removerImagens() async {
    for (final image in images){
      //correcao de bug, no iOS ocorre um erro com as imagens, para diferenciar a origem do firebase e da internet
      if(!newImages.contains(image) && image.contains('firebase')){
        try{
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e){
          debugPrint('Falha ao deletar $image');
        }
      }
    }
  }

  Future atualizarImagens(List<String> updateImages) async {
     await firestoreRef.updateData({'images': updateImages});
     images = updateImages;
  }

  Product clone() {
    return Product.fromObject(
      id: id,
      name : name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      deleted: deleted,
    );
  }

  void delete() {
    firestoreRef.updateData({'deleted': true});
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }

}
