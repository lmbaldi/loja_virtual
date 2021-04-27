import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';

class AdminUsersManager extends ChangeNotifier {

  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  List<User> users = [];
  List<String> get names => users.map((e) => e.name).toList();

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    //recebe a atualizacao em tempo real
    _subscription = firestore.collection('users').snapshots().listen((snapshot){
      users = snapshot.documents.map((d) => User.fromDocument(d)).toList();
      users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
    // firestore.collection('users').getDocuments().then((snapshot){
    //   users = snapshot.documents.map((d) => User.fromDocument(d)).toList();
    //   users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    //   notifyListeners();
    // });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
