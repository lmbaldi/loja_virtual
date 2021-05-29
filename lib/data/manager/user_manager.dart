import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../../helpers/helpers.dart';
import '../data.dart';

class UserManager extends ChangeNotifier {

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  User user;

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

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _loadingFace = false;
  bool get loadingFace => _loadingFace;
  set loadingFace(bool value){
    _loadingFace = value;
    notifyListeners();
  }

  void facebookLogin({Function onFail, Function onSuccess}) async {
    loadingFace = true;
    final result = await FacebookLogin().logIn(['email', 'public_profile']);
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token
        );
        final authResult = await auth.signInWithCredential(credential);
        if(authResult.user != null ){
          final firebaseUser = authResult.user;

          user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
          );
          await user.saveData();
          user.saveToken();
          onSuccess();
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        onFail(result.errorMessage);
        break;
    }
    loadingFace = true;
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try{
      final AuthResult result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      user.saveToken();
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
      await user.saveToken();
      final docAdmin = await firestore.collection('admins').document(user.id).get();
      if(docAdmin.exists){
        user.admin = true;
      }
      notifyListeners();
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }
}