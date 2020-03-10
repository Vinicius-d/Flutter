import 'package:flutter/material.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:scoped_model/scoped_model.dart';
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
                TextFormField(
                  controller: _numberOneController,
                  decoration: InputDecoration(hintText: "Numero de SOS 1"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberTwoController,
                  decoration: InputDecoration(hintText: "Numero de SOS 2"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberThreeController,
                  decoration: InputDecoration(hintText: "Numero de SOS 3"),

                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _numberFourController,
                  decoration: InputDecoration(hintText: "Numero de SOS 4"),

                ),
                TextFormField(
                  controller: _numberFiveController,
                  decoration: InputDecoration(hintText: "Numero de SOS 5"),

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
                      //model.signUp(
                      //   userData: userData,
                      // pass: _passController.text,
                      //onSuccess: _onSuccess,
                      //onFail: _onFail);

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
        SnackBar(content: Text("Numero cadastrado com sucesso"),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          duration: Duration(seconds: 2),
        )
    );
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