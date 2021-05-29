import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../services/cielo_payment.dart';
import '../../helpers/helpers.dart';
import '../data.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  num price;
  String userId;
  String orderId;
  String payId;
  Timestamp date;
  Address address;
  List<CartProduct> items;
  Status status;
  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef => firestore.collection('orders').document(orderId);

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;

    items = (doc.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
    status = Status.values[doc.data['status'] as int];
    payId = doc.data['payId'] as String;
  }

  void updateFromDocument(DocumentSnapshot doc){
    status = Status.values[doc.data['status'] as int];
  }

  Future<void> save() async {
    firestoreRef.setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
      'status': status.index,
      'data': Timestamp.now(),
      'payId': payId,
    });
  }

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return R.string.canceled;
      case Status.preparing:
        return R.string.inPreparation;
      case Status.transporting:
        return R.string.onCarriage;
      case Status.delivered:
        return R.string.delivered;
      default:
        return '';
    }
  }

  Function() get advance {
    return status.index <= Status.transporting.index
        ? () {
            status = Status.values[status.index + 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            firestoreRef.updateData({'status': status.index});
          }
        : null;
  }

  Future<void> cancel() async {
    try {
      await CieloPayment().cancel(payId);
      status = Status.canceled;
      firestoreRef.updateData({'status': status.index});
    } catch (e){
      debugPrint('Erro ao cancelar');
      return Future.error('Falha ao cancelar');
    }
  }

  @override
  String toString() {
    return 'Order{price: $price, userId: $userId, orderId: $orderId, date: $date, address: $address, items: $items}';
  }
}
