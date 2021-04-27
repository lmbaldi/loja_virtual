import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helpers/helpers.dart';
import '../data.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  User user;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;
  bool get adminEnabled => user != null && user.admin;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try{
      final AuthResult result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    }on  PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try{
      final AuthResult result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSuccess();
    }on  PlatformException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = true;
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if(currentUser != null){
      final DocumentSnapshot docUser =  await firestore.collection('users').document(currentUser.uid).get();
      //obtem o usuario
      user = User.fromDocument(docUser);

      final docAdmin = await firestore.collection('admins').document(user.id).get();
      if(docAdmin.exists){
        user.admin = true;
      }
      print('admin ==> ${user.admin}');
      notifyListeners();
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

}