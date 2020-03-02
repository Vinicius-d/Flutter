import 'package:flutter/material.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
class SingUpScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,

      ),
      drawer:CustomDrawer(_pageController),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome Completo"),

              validator: (text){
                if(text.isEmpty )
                  return "Nome inválido!";
              },
            ),
            SizedBox(height: 16.0),
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
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Endereço"
              ),
              validator: (text){
                if(text.isEmpty) return "Endereço Inválida";
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
