import 'package:flutter/material.dart';
import 'package:helpme_app/Screens/cellnumber_srceen.dart';
import 'package:helpme_app/Screens/home_screen.dart';
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
        onTap: (){
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SingUpScreen()));
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
