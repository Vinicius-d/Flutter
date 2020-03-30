import 'package:flutter/material.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Screens/home_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
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
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
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
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
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
        SnackBar(content: Text("Usuário criado com Sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();


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