import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/core/helpers/firebase/firebase_errors.dart';
import 'package:loja_virtual/core/models/user.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(true);
  }

  void setLoading(bool value) {
    loading = true;
  }
}
