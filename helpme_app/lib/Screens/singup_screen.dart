import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Screens/home_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}


class _SingUpScreenState extends State<SingUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cepController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //Map<String, dynamic> userData = Map();

  @override
  Widget build(BuildContext context) {


    //final _pageController = PageController();
    return Scaffold(
      key: _scaffoldKey,
        appBar: GradientAppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
          backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
        ),
        //drawer: CustomDrawer(_pageController),
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
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome Completo"),
                  validator: ( text) {
                    if(text.isEmpty)
                    return 'Nome inválido';
                  }
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                  }
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (text){
                    if(text.isEmpty || text.length < 6) return "Senha inválida!";
                  },
                ),

                SizedBox(height: 16.0),
                TextFormField(
                  controller: _cepController,
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XXXXX-XXX", maskTWO: "XXXXXXXXX"),
                  ],
                  decoration: InputDecoration(hintText: "CEP"),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (text){
                    if(text.isEmpty) return "CEP inválido!";
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                    textColor: Colors.white,
                    color: Color.fromRGBO(165, 88, 157, 1),
                    onPressed: () async {
                      if(await DataConnectionChecker().hasConnection == true){


                      if (_formkey.currentState.validate()) {

                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "cep": _cepController.text
                        }; //senha e salva no database di firebase

                        model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            cep:_cepController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                        /*model.anddress(
                          NCEP:_cepController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);*/
                      }

                    }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Sem conexão com a internet!"),
                              content: new Text(
                                  "Por Favor, Conecte com a internet para se cadastrar!"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                },
                                ),
                              ],
                            );
                          },
                        );

                      }
                    }

                  ),
                ),
              ],
            ),

          );

        }));
  }

  void _onSuccess() {

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário criado com Sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){

      Navigator.of(context).pop(
        CircularProgressIndicator()
      );


    });

  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar Usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}