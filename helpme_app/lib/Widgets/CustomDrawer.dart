import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:helpme_app/Screens/login_screen.dart';
import 'package:helpme_app/Title/DrawerTitle.dart';
import 'package:scoped_model/scoped_model.dart';
String queryName;
/*pegaID()async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  queryName = await Firestore.instance
      .collection('users')
      .document(user.uid)
      .get()
      .then((DocumentSnapshot) =>
  (DocumentSnapshot.data['name'].toString()));
}*/

class CustomDrawer extends StatelessWidget {


  final PageController  pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    /*pegaID();*/
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(

        gradient: LinearGradient(

            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        ),
      ),
    );
    return Drawer(

      child: Stack(

        children: <Widget>[

          ListView(padding: EdgeInsets.zero, children: <Widget>[
            Container(
                color: Color.fromRGBO(119, 1, 108, 1),
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8),
                height: 170.0,
                child: Stack(
                  children: <Widget>[

                    Positioned(
                      top: 18.0,
                      left: 18.0,
                      child: Text(
                        "Ajude-se",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text(

                                "Olá, ${!model.isLoggedIn() ? "" :model.userData["name"]}",
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              SizedBox(height: 16.0),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Entre ou Cadastre-se": "Sair",
                                  style: TextStyle(
                                    color:  Color.fromRGBO(243, 181, 247, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>LoginScreen())
                                    );
                                  else
                                    model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      )
                    ),
                  ],
                )
              //child: Text('Drawer Header'),
              //decoration: BoxDecoration(color: Colors.greenAccent),
            ),

            Divider(),

            DrawerTile(Icons.home,"Início",pageController,0),
            DrawerTile(Icons.add_call,"Numeros SOS",pageController,1),
            DrawerTile(Icons.tag_faces,"Mensagens pra Você",pageController,2),
            /*ListTile(
              title: Text('Item 1'),
              onTap: () {
                ;
                //Navigator.pop(context); - este item chama a proxima tela
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Navigator.pop(context); item que chama a prox tela
              },
            ),*/
            _buildDrawerBack(),
          ]),
        ],
      ),
    );
  }
}
