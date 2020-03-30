import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_correios/flutter_correios.dart';
import 'package:flutter_correios/model/resultado_cep.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;


  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }
  anddress( String NCEP) async {
    print("fui chamado");
    final FlutterCorreios fc = FlutterCorreios();

    //consultar cep
    ResultadoCEP resultado = await fc.consultarCEP(cep: "$NCEP");
    String bairro = ("${resultado.bairro}");
    String cidade =("${resultado.cidade}");
    String estado = ("${resultado.estado}");
    print("logradouro: ${resultado.logradouro}");
    print("   Estado Km2: ${resultado.estadoInfo.areaKm2}");
    print("   Estado IBGE: ${resultado.estadoInfo.codigoIBGE}");
    print("   Estado Nome: ${resultado.estadoInfo.nome}");
    print("   Cidade Km2: ${resultado.cidadeInfo.areaKm2}");
    print("   Cidade IBGE: ${resultado.cidadeInfo.codigoIBGE}");


    String user = firebaseUser.uid;

    try{
      final databaseReference = Firestore.instance;
      databaseReference.collection('users').document(user).collection(
          'address').document(user).setData({
        //"CEP": CEP,
        "ESTADO": estado,
        "CIDADE": cidade,
        "BAIRRO": bairro ,

      });
      print("SAlvei o cep");
    }catch(e){
      print("erro ao salvar end: $e");
    }
    _loadCurrentUser();
    isLoading = false;
    notifyListeners();

  }


  void signUp({@required Map<String, dynamic> userData, @required String pass,String cep,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) {
    isLoading = true;

    notifyListeners();
    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((authResult) async {
      firebaseUser = authResult.user;
      /*_auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((authResult) async {
      firebaseUser = authResult.user;*/

      await _saveUserData(userData);
      print("salvei o usuario, agora vou chamar o cep");
      anddress(cep);
      onSuccess();
      isLoading = false;
      notifyListeners();


    }).catchError((e) {
      print('O ERRO ao criar user: $e');
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  Future<void> saveCell({@required Map<String,
      dynamic> userData, String numberOne, String numberTwo, String numberThree,
    String numberFour, String numberFive,
    VoidCallback onSuccess, VoidCallback onFail}) async {
    String user = firebaseUser.uid;

    final databaseReference = Firestore.instance;
    databaseReference.collection('users').document(user).collection(
        'cell number').document(user).setData({
      "numberOne": numberOne == null ? "" : numberOne,
      "numberTwo": numberTwo,
      "numberThree": numberThree,
      "numberFour": numberFour,
      "numberFive": numberFive
    });
    // await Firestore.instance.collection("users").document(user).collection("number").document().setData({"numberOne":numberOne,
    //  "numberTwo":numberTwo,"numberThree":numberThree, "numberFour": numberFour, "numberFive": numberFive}, merge: true);

    onSuccess();
    //isLoading = false;
    notifyListeners();
    _loadCurrentUserCell();

  }


  void signIn({@required String email, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    /*_auth.signInWithEmailAndPassword(email: email, password: pass).then(
            (authResult) async {
          firebaseUser = authResult.user;*/
    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
            (authResult) async {
          firebaseUser = authResult.user;

          await _loadCurrentUser();

          onSuccess();
          isLoading = false;
          notifyListeners();
        }).catchError((e) {
      print('O ERRO ao logar E ESSE: $e');
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser =
        await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
        /*await Firestore.instance.collection("users").document(firebaseUser.uid)
            .collection("cell number").document(firebaseUser.uid)
            .get();
        userData = docUser.data;*/
        print(userData);
      }
    }
    notifyListeners();
  }

  Future<Null> _loadCurrentUserCell() async {
    if (firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser =
        //await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        //userData = docUser.data;
        await Firestore.instance.collection("users").document(firebaseUser.uid)
            .collection("cell number").document(firebaseUser.uid)
            .get();
        userData = docUser.data;
        print(userData);
      }
    }
    notifyListeners();
  }



}