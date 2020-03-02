import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Screens/login_screen.dart';
import 'package:helpme_app/Title/DrawerTitle.dart';


class CustomDrawer extends StatelessWidget {
  final PageController  pageController;
  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
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
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Olá,",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          GestureDetector(
                            child: Text(
                              "Entre ou Cadastre-se",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                          ),
                        ],
                      ),
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
