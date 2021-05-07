import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../../helpers/helpers.dart';
import '../../services/cep.dart';
import '../data.dart';

class CartManager extends ChangeNotifier{
  List<CartProduct> items = [];
  User user;
  Address address;
  final Firestore firestore = Firestore.instance;

  num deliveryPrice;
  num productsPrice = 0.0;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();
    //carrega o carrinho para o novo usuario logado
    if (user != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      //verifica se os produtos sao iguais para conta-los
      final produtosIguais = items.firstWhere((p) => p.stackable(product));
      //incrementa a quantidade
      produtosIguais.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
      notifyListeners();
    }
  }

  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i<items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if(cartProduct.id != null)
    user.cartReference
        .document(cartProduct.id)
        .updateData(cartProduct.toCartItemMap());
  }

  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    //remove o item no firebase
    user.cartReference.document(cartProduct.id).delete();
    //remove o listener do cartProduct porque ele nao vai mais ser utilizado
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

   Future<void> getAddress(String cep) async {
    final cepAbertoService = CepAbertoService();
    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);
      if(cepAbertoAddress != null){
        address = Address(
          street: cepAbertoAddress.logradouro,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.cidade.nome,
          state: cepAbertoAddress.estado.sigla,
          lat: cepAbertoAddress.latitude,
          long:  cepAbertoAddress.longitude
        );
        notifyListeners();
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }

  void setAddress(Address address) async {
    loading = true;

    this.address = address;

    if(await calculateDelivery(address.lat, address.long)){
    user.setAddress(address);
    loading = false;
    } else {
    loading = false;
    return Future.error('${R.string.deliveryError} :(');
    }

  }

  void removeAddress(){
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.document('aux/delivery').get();

    final latStore = doc.data['lat'] as double;
    final longStore = doc.data['long'] as double;

    final base = doc.data['base'] as num;
    final km = doc.data['km'] as num;
    final maxkm = doc.data['maxkm'] as num;

    //obtem  a distancia
    double dis = await Geolocator().distanceBetween(latStore, longStore, lat, long);

    //converte para km
    dis /= 1000.0;

    debugPrint('Distance $dis');
    //verifica a distancia maxima para entrega
    if(dis > maxkm){
      return false;
    }

    deliveryPrice = base + dis * km;
    return true;
  }


}
