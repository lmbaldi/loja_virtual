import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;

  User({this.email, this.password, this.name, this.id});

  //recuperando os dados no login
  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  DocumentReference get fireStoreRef => Firestore.instance.document('users/$id');
  CollectionReference get cartReference => fireStoreRef.collection('cart');

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  Future<void> saveData() async {
    await fireStoreRef.setData(toMap());
  }
}
