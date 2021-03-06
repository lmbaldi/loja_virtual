import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class StoresManager extends ChangeNotifier{

  StoresManager(){
    _loadStoreList();
    _startTimer();
  }

  List<Store> stores = [];
  Timer _timer;
  final Firestore firestore = Firestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').getDocuments();
    stores = snapshot.documents.map((e) => Store.fromDocument(e)).toList();
    notifyListeners();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }
  void _checkOpening(){
    for(final store in stores)
      store.updateStatus();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    //para evitar que to timer fique rodando sem necessidade
    _timer?.cancel();
  }
}