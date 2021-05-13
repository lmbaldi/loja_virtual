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
  Order.fromDocument(DocumentSnapshot doc){
    orderId = doc.documentID;

    items = (doc.data['items'] as List<dynamic>).map((e){
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
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

  @override
  String toString() {
    return 'Order{price: $price, userId: $userId, orderId: $orderId, date: $date, address: $address, items: $items}';
  }
}