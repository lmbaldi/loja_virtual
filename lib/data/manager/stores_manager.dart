import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoresManager extends ChangeNotifier{

  StoresManager(){
    _loadStoreList();
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();
    notifyListeners();
  }


}