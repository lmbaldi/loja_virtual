import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';

class User {
  String id;
  String name;
  String email;
  String cpf;
  String password;
  String confirmPassword;
  bool admin = false;

  User({this.email, this.password, this.name, this.id});

  //recuperando os dados no login
  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document.data['cpf'] as String;
    if(document.data.containsKey('address')){
      address = Address.fromMap(
          document.data['address'] as Map<String, dynamic>);
    }
  }

  DocumentReference get fireStoreRef => Firestore.instance.document('users/$id');
  CollectionReference get cartReference => fireStoreRef.collection('cart');
  Address address;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
      if(cpf != null)
        'cpf': cpf
    };
  }

  Future<void> saveData() async {
    await fireStoreRef.setData(toMap());
  }

  void setAddress(Address address){
    this.address = address;
    saveData();
  }

  void setCpf(String cpf){
    this.cpf = cpf;
    saveData();
  }
}
