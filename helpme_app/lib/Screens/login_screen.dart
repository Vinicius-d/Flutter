import 'package:flutter/material.dart';
import 'package:helpme_app/Screens/singup_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';


class LoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(

        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[


          FlatButton(
            child: Text(
              "Criar Conta",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SingUpScreen()));
            },
          ),
        ],

      ),

      drawer: CustomDrawer(null),

      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty || !text.contains("@"))
                  return "E-mail inválido!";
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Senha"
              ),
              obscureText: true,
              validator: (text){
                if(text.isEmpty || text.length < 6) return "Senha Inválida";
              },

            ),

            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
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
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  if(_formkey.currentState.validate()){

                  }
                },
              ),
            ),
          ],
        ),
      ),

    );

  }

}
