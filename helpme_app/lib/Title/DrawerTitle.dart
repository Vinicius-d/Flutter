import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:helpme_app/Screens/cellnumber_srceen.dart';
import 'package:helpme_app/Screens/home_screen.dart';
import 'package:helpme_app/Screens/message.dart';
import 'package:helpme_app/Screens/singup_screen.dart';
class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;
  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {


    return Material(

      color: Colors.transparent,
      child: InkWell(
        onTap: () async {

          Navigator.of(context).pop();


          //AQUI CHAMA OS ITENS DO DRAWER
          if(page == 0){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()));
          }
          if(page == 1){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CellNumber()));
          }
          if(page == 2){
            if(await DataConnectionChecker().hasConnection == true){
            Navigator.push(

                context,
                MaterialPageRoute(builder: (context) => CarouselDemo()));
          }

          else{
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text("Sem conexão com a internet!"),
                  content: new Text(
                      "Por Favor, Conecte com a internet para acessar as mensagens!"),
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
  },
        child: Container(
          height: 60.0,

          child: Row(

            children: <Widget>[
              SizedBox(width: 20),
              Icon( icon,
                size:32,
                color: Colors.black,
              ),
              SizedBox(width: 32.0,),

              Text(
                text,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                ),

              ),


            ],

          ),
        ),
      ),
    );

  }
}
