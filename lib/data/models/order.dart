import 'package:cloud_firestore/cloud_firestore.dart';
import '../../helpers/helpers.dart';
import '../data.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  num price;
  String userId;
  String orderId;
  Timestamp date;
  Address address;
  List<CartProduct> items;
  Status status;
  final Firestore firestore = Firestore.instance;

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
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
      'status': status.index,
      'data': Timestamp.now(),
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
            firestore
                .collection('orders')
                .document(orderId)
                .updateData({'status': status.index});
          }
        : null;
  }

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            firestore
                .collection('orders')
                .document(orderId)
                .updateData({'status': status.index});
          }
        : null;
  }

  @override
  String toString() {
    return 'Order{price: $price, userId: $userId, orderId: $orderId, date: $date, address: $address, items: $items}';
  }
}
