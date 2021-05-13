import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';

class Order {

  num price;
  String userId;
  String orderId;
  Timestamp date;
  Address address;
  List<CartProduct> items;
  final Firestore firestore = Firestore.instance;

  Order.fromCartManager(CartManager cartManager){
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  Future<void> save() async{
    firestore.collection('orders').document(orderId).setData(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price': price,
        'user': userId,
        'address': address.toMap(),
      }
    );
  }


}