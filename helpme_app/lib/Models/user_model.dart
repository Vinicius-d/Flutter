import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void singUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess,@required VoidCallback onFail} ) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"].trim(),

        password: pass

    ).then((authResult) async{
      //pediu pra add as FirebaseUser;

    firebaseUser = authResult.user;
    await _saveUserData(userData);

    onSuccess();
    isLoading = false;
    notifyListeners();
    }).catchError((e){
      print('O ERRO E ESSE: $e');
      onFail();
      isLoading = false;
      notifyListeners();

    });


  }

  void singIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }
  void singOut() async{
   await _auth.signOut();
   userData = Map();
   firebaseUser = null;
   notifyListeners();

  }

  void recoverPass() {}
  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData =userData;
   await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }
}

