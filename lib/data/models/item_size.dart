class ItemSize{
  String name;
  num price;
  int stock;

  ItemSize({this.name, this.price, this.stock});

  bool get hasStock => stock > 0;

  ItemSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }


  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }


}