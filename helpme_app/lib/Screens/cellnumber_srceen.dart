import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:scoped_model/scoped_model.dart';

String queryN1;
String queryN2;
String queryN3;
String queryN4;
String queryN5;
bool isLoadingCell = false;


Future<Null> getNumbers() async {
  isLoadingCell = true;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  queryN1 = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cell number')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
          (DocumentSnapshot.data['numberOne'].toString()));

  queryN2 = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cell number')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
          (DocumentSnapshot.data['numberTwo'].toString()));

  queryN3 = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cell number')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
          (DocumentSnapshot.data['numberThree'].toString()));

  queryN4 = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cell number')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
          (DocumentSnapshot.data['numberFour'].toString()));

  queryN5 = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .collection('cell number')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
          (DocumentSnapshot.data['numberFive'].toString()));
  isLoadingCell = false;
}



class CellNumber extends StatefulWidget {
  @override
  _CellNumberState createState() => _CellNumberState();

}

class _CellNumberState extends State<CellNumber> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  final _numberOneController = TextEditingController();
  final _numberTwoController = TextEditingController();
  final _numberThreeController = TextEditingController();
  final _numberFourController = TextEditingController();
  final _numberFiveController = TextEditingController();


  Map<String, dynamic> userData = Map();




  @override
  Widget build(BuildContext context) {







    final _pageController = PageController();
    return Scaffold(
        backgroundColor: Color.fromRGBO(252, 239, 246, 1),
        key: _scaffoldKey,
        appBar: GradientAppBar(
          title: Text("Gerenciar Números de Telefone"),
          centerTitle: true,
          backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
          backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
        ),

        drawer: CustomDrawer(_pageController),
        body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {

              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XX-XXXXX-XXXX", maskTWO: "XX-XXX-XXXXXX"),
                  ],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _numberOneController
                    ..text =
                        "${!model.isLoggedIn() ? "" : queryN1 == null ? "" : queryN1}",
                  decoration: InputDecoration(
                      labelText: "Insira um numero de telefone"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XX-XXXXX-XXXX", maskTWO: "XX-XXX-XXXXXX"),
                  ],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _numberTwoController
                    ..text =
                        "${!model.isLoggedIn() ? "" : queryN2 == null ? "" : queryN2}",
                  decoration: InputDecoration(
                      labelText: "Insira um numero de telefone"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XX-XXXXX-XXXX", maskTWO: "XX-XXX-XXXXXX"),
                  ],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _numberThreeController
                    ..text =
                        "${!model.isLoggedIn() ? "" : queryN3 == null ? "" : queryN3}",
                  decoration: InputDecoration(
                      labelText: "Insira um numero de telefone"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XX-XXXXX-XXXX", maskTWO: "XX-XXX-XXXXXX"),
                  ],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _numberFourController
                    ..text =
                        "${!model.isLoggedIn() ? "" : queryN4 == null ? "" : queryN4}",
                  decoration: InputDecoration(
                      labelText: "Insira um numero de telefone"),
                ),
                TextFormField(
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XX-XXXXX-XXXX", maskTWO: "XX-XXX-XXXXXX"),
                  ],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _numberFiveController
                    ..text =
                        "${!model.isLoggedIn() ? "" : queryN5 == null ? "" : queryN5}",
                  decoration: InputDecoration(
                      labelText: "Insira um numero de telefone"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Salvar",
                        style: TextStyle(
                          fontSize: 18.0,

                        )
                    ),
                    textColor: Colors.white,
                    color: Color.fromRGBO(165, 88, 157, 1),
                    onPressed: () {
                      Map<String, dynamic> userData = {
                        "NumberOne": _numberOneController.text,
                        "NumberTwo": _numberTwoController.text,
                        "NumberTheree": _numberThreeController.text,
                        "numberFour": _numberFourController.text,
                        "numberFive": _numberFiveController.text,
                      }; //senha e salva no database di firebase
                      model.saveCell(
                          userData: userData,
                          numberOne: _numberOneController.text,
                          numberTwo: _numberTwoController.text,
                          numberThree: _numberThreeController.text,
                          numberFour: _numberFourController.text,
                          numberFive: _numberFiveController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }




  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Numero(s) Adicionado(s) com Sucesso!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 3)).then((_) async {
      await getNumbers();

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CellNumber()));
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao cadastrar numero!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
