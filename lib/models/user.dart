import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  User({this.email, this.password, this.name, this.id});

  DocumentReference get fireStoreRef => Firestore.instance.document('users/$id');

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
