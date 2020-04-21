import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Screens/singup_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(252, 239, 246, 1),
      key: _scaffoldKey,
        appBar: GradientAppBar(
          title: Text("Entrar"),
          centerTitle: true,
          backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
          backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 15.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SingUpScreen()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(null),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
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
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if(_emailController.text.isEmpty){
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("Insira seu Email para Recuperação"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            )
                        );
                        }
                        else{
                          model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(
                        SnackBar(content: Text("Verifique seu E-email"),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 2),
                        )
                        );
                        }


                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Entrar",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      textColor: Colors.white,
                      color: Color.fromRGBO(165, 88, 157, 1),
                      onPressed: () async {
                      if(await DataConnectionChecker().hasConnection == true) {
                        if (_formkey.currentState.validate()) {}
                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Sem conexão com a internet!"),
                              content: new Text(
                                  "Por Favor, Conecte com a internet para Logar!"),
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
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Usuário autenticado com sucesso!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        )
    );
    Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
    });
  }


  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao Logar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
  }




