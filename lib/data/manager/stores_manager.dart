import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class StoresManager extends ChangeNotifier{

  StoresManager(){
    _loadStoreList();
  }

  List<Store> stores = [];
  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();
    stores = snapshot.documents.map((e) => Store.fromDocument(e)).toList();
    notifyListeners();
  }


}