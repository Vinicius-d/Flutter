import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Screens/login_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'OneSingal.dart';

String message ="!SOS! Olá você está recebendo essa mensagem pois necessito de sua ajuda nesse momento, entre em contato comigo com URGÊNCIA";


_launchURL() async {
  const url = 'http://cvvweb.mysuite1.com.br/client/chatan.php?h=&inf=&lfa=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _sendSMS(String message, List<String> recipents, context) async {


  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });

  print(_result);
}

class HomePage extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  final _pageController = PageController();




  @override
  Widget build(BuildContext context) {
    var CallConect = OneSignalConnect();

    CallConect.initOneSignal();
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
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
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                    ),

                    onPressed: () async {

                      FirebaseUser user = await FirebaseAuth.instance.currentUser();
                      List<String> recipents = [];
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),

                            ),
                            elevation: 30.0,
                            backgroundColor: Colors.blue,


                            child: new Row(
                              mainAxisSize: MainAxisSize.max,

                              children: [

                                new CircularProgressIndicator(backgroundColor: Colors.amber,strokeWidth: 10,),
                                new Text("   ENVIANDO MENSAGEM!"),

                              ],
                            ),
                          );
                        },
                      );


                       if(user != null){
                         print("USUSARIO LOGADO");


                        final queryN1 = await Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .collection('cell number')
                          .document(user.uid)
                          .get()
                          .then((DocumentSnapshot) =>
                              (DocumentSnapshot.data['numberOne'].toString()));
                      if (queryN1 != null) {
                        recipents.add(queryN1);
                      }
                      final queryN2 = await Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .collection('cell number')
                          .document(user.uid)
                          .get()
                          .then((DocumentSnapshot) =>
                              (DocumentSnapshot.data['numberTwo'].toString()));
                      if (queryN2 != null) {
                        print(queryN2);
                        recipents.add(queryN2);
                      }
                      final queryN3 = await Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .collection('cell number')
                          .document(user.uid)
                          .get()
                          .then((DocumentSnapshot) => (DocumentSnapshot
                              .data['numberThree']
                              .toString()));
                         if (queryN3 != null) {
                        print(queryN3);
                        recipents.add(queryN3);
                      }
                         final queryN4 = await Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .collection('cell number')
                          .document(user.uid)
                          .get()
                          .then((DocumentSnapshot) =>
                              (DocumentSnapshot.data['numberFour'].toString()));
                      if (queryN4 != null) {
                        print(queryN4);
                        recipents.add(queryN4);
                      }
                      final queryN5 = await Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .collection('cell number')
                          .document(user.uid)
                          .get()
                          .then((DocumentSnapshot) =>
                              (DocumentSnapshot.data['numberFive'].toString()));
                      if (queryN5 != null) {
                        print(queryN5);
                        recipents.add(queryN5);
                      }


                      _sendSMS(message, recipents,context);

                       }
                      if(user == null){

                         showDialog(
                           context: context,
                           builder: (BuildContext context) {
                             // return object of type Dialog
                             return AlertDialog(
                               title: new Text("Usuário não Autenticado!"),
                               content: new Text("Por Favor Logue no sistema para ter acesso a função SOS!"),
                               actions: <Widget>[
                                 // usually buttons at the bottom of the dialog
                                 new FlatButton(
                                   child: new Text("OK"),
                                   onPressed: () {
                                     Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (context) => LoginScreen()));
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
              ),
            ]),


          ),

        ],
      ),
    );
  }
}
