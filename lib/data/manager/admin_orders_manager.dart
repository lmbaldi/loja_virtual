import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class AdminOrdersManager extends ChangeNotifier {
  List<Order> _orders = [];
  User userFilter;
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateAdmin(bool adminEnabled) {
    _orders.clear();
    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();

    if(userFilter != null){
      output = output.where((o) => o.userId == userFilter.id).toList();
    }

    return output;
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.documentChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.document));
            break;
          case DocumentChangeType.modified:
            final modOrder = _orders
                .firstWhere((o) => o.orderId == change.document.documentID);
            modOrder.updateFromDocument(change.document);
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(User user) {
    userFilter = user;
    notifyListeners();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel();
  }


}
