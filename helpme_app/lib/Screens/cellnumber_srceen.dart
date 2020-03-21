import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';

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
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  String queryN1="";
  Map<String, dynamic> userData = Map();

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();



    return Scaffold(

        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Gerenciar Numeros de Telefone"),
          centerTitle: true,
        ),
        drawer: CustomDrawer(_pageController),
        body:

        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(

              child: CircularProgressIndicator(),
            );

          return Form(

            key: _formkey,

            child: ListView(


              padding: EdgeInsets.all(16.0),
              children: <Widget>[



                TextFormField (
                  controller: _numberOneController,

                  //decoration: InputDecoration(hintText:"$queryN1"),

                  decoration: InputDecoration(hintText:"${!model.isLoggedIn() ? "": model.userData["numberOne"]}",labelText: "Insira um numero de telefone"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberTwoController,
                  decoration: InputDecoration(hintText: "${!model.isLoggedIn() ? "": model.userData["numberTwo"]}",labelText: "Insira um numero de telefone"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberThreeController,
                  decoration: InputDecoration(hintText: "${!model.isLoggedIn() ? "": model.userData["numberThree"]}",labelText: "Insira um numero de telefone"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberFourController,
                  decoration: InputDecoration(hintText: "${!model.isLoggedIn() ? "": model.userData["numberFour"]}",labelText: "Insira um numero de telefone"),


                ),

                 TextFormField(
                  controller:  _numberFiveController,
                  decoration: InputDecoration(hintText: "${!model.isLoggedIn() ? "": model.userData["numberFive"]}",labelText: "Insira um numero de telefone"),

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
                        )),
                    textColor: Colors.white,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    onPressed: () {
                      int cont =0;
                      setState(() {
                        cont++;
                      });

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

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Numero(s) Adicionado(s) com Sucesso!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()));

    });

  }
    void _onFail() {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Falha ao cadastrar numero!"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          )
      );
    }



}