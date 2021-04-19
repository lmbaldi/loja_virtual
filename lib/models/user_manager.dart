import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'models.dart';

class UserManager{

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(User user) async {

    try{
      final AuthResult result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
    }on  PlatformException catch(e){
      print(e);
    }

  }
}