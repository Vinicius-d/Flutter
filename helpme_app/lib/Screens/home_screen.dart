
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL() async {
  const url = 'http://cvvweb.mysuite1.com.br/client/chatan.php?h=&inf=&lfa=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HomePage extends StatelessWidget {


  final _pageController = PageController();

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: GradientAppBar(

        backgroundColorStart: Colors.deepPurpleAccent,
        backgroundColorEnd: Colors.lightBlue,
      ),
      drawer: CustomDrawer(_pageController),
      body: Column(

        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0)),
          Row(

            children: <Widget>[
              Padding(padding: EdgeInsets.all(5.0)),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(100.0),
                    side: BorderSide(
                        color: Colors.black87,
                        style: BorderStyle.solid,
                        width: 10)),

                //borda do botão

                color: Colors.cyanAccent,
                textColor: Colors.white,

                padding: EdgeInsets.all(57.0),
                splashColor: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      size: 50,
                    ),
                  ],
                ),
                onPressed: () {
                  _launchURL();
                },
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              FlatButton(

                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(100.0),
                    side: BorderSide(
                        color: Colors.black87,
                        style: BorderStyle.solid,
                        width: 10)),

                //borda do botão

                color: Colors.cyanAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(57.0),
                splashColor: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      size: 50,
                    ),
                  ],
                ),
                onPressed: () {
                  launch("tel:" + Uri.encodeComponent('188'));
                },
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(80.0)),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Animator(
                    tween: Tween<double>(begin: 1.5, end: 2),
                    curve: Curves.easeOutQuad,
                    cycles: 0,
                    duration: Duration(milliseconds: 1500),
                    builder: (anim) => Transform.scale(
                      scale: anim.value,
                      child: RaisedButton(
                        // botao SOS
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                            side: BorderSide(
                                color: Colors.black87,
                                style: BorderStyle.solid,
                                width: 5)),
                        color: Colors.red,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(50.0),
                        splashColor: Colors.yellow,

                        child: Text(
                          "SOS",
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.normal),
                        ),

                        onPressed: () {},
                      ),
                    ),
                  ),
                ]),
          ),
          Container(color: Colors.red,),
          Container(color: Colors.red,),
          Container(color: Colors.red,),
          Container(color: Colors.red,),
        ],

      ),


    );

  }


}
