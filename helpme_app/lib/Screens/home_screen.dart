import 'dart:ui';
import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Screens/login_screen.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'OneSingal.dart';

String message = "!SOS! Olá você está recebendo essa mensagem pois necessito de sua ajuda nesse momento, entre em contato comigo com URGÊNCIA, essa é minha localização:";
String messageSMS = "!SOS! Olá você está recebendo essa mensagem pois necessito de sua ajuda nesse momento, entre em contato comigo com URGÊNCIA, essa é minha localização: $local";
String longitude = "";
String latitude = "";

String local = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

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

}

Future<void> share() async {
  await FlutterShare.share(
      title: 'Minha Localização',
      text: '$message',
      linkUrl: '$local',
      chooserTitle: 'Minha Localização');
}

_getCurrentLocation() async {
  Position _currentPosition;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
    _currentPosition = position;
    print(
        "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
    latitude = "${_currentPosition.latitude}";
    longitude = "${_currentPosition.longitude}";
  }).catchError((e) {
    print(e);
  });
}

class HomePage extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  final _pageController = PageController();

  @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var CallConect = OneSignalConnect();
    CallConect.initOneSignal();

    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 239, 246, 1),
      appBar: GradientAppBar(
        title: Text("Helpme app"),
        centerTitle: true,
        backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
        backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
      ),
      drawer: CustomDrawer(_pageController),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: <Widget>[
            Expanded(child:
            Container(child: LayoutBuilder(builder: (_, constraints) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //margin: const EdgeInsets.only(bottom: 1.0),
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () { _launchURL();},
                            child: ClipOval(
                              child: Container(
                                color: Color.fromRGBO(134, 203, 232, 1),
                                height: 200.0, // height of the button
                                width: 150.0, // width of the button
                                child: Icon(
                                  Icons.chat,
                                  size: 70,
                                  color: Color.fromRGBO(1, 84, 164, 1),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                          GestureDetector(
                            onTap: () { launch("tel:" + Uri.encodeComponent('188'));},
                            child: ClipOval(
                              child: Container(
                                color: Color.fromRGBO(134, 203, 232, 1),
                                height: 200.0, // height of the button
                                width: 150.0, // width of the button
                                child: Icon(
                                  Icons.call,
                                  size: 80,
                                  color: Color.fromRGBO(1, 84, 164, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      width: constraints.maxWidth * .9,
                      height: constraints.maxHeight * .05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(40, 00, 0, 00)),
                          Text(
                            "Chat CVV",
                            style: GoogleFonts.oswald(
                                fontSize: 20,
                                color: Color.fromRGBO(1, 84, 164, 1),
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(110, 00, 0, 00)),
                          Text("Chamada CVV",
                              style: GoogleFonts.oswald(
                                  fontSize: 20,
                                  color: Color.fromRGBO(1, 84, 164, 1),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20.0)),
                    Container(
                      width: constraints.maxWidth * .9,
                      height: constraints.maxHeight * .4,
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
                                        borderRadius:
                                        new BorderRadius.circular(100.0),
                                        side: BorderSide(
                                            color:
                                            Color.fromRGBO(210, 32, 4, 1),
                                            style: BorderStyle.solid,
                                            width: 5)),
                                    color: Color.fromRGBO(210, 32, 4, 1),
                                    textColor: Colors.white,
                                    padding: EdgeInsets.all(37.0),
                                    splashColor: Colors.yellow,
                                    child: Text(
                                      "SOS",
                                      style: GoogleFonts.oswald(fontSize: 30),
                                      //TextStyle(fontSize: 20, fontStyle: FontStyle.normal) ,
                                    ),
                                    onPressed: () async {
                                      FirebaseUser user =
                                      await FirebaseAuth.instance.currentUser();
                                      List<String> recipents = [];


                                      if (user != null) {
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
                                                  new CircularProgressIndicator(
                                                    backgroundColor: Colors.amber,
                                                    strokeWidth: 10,
                                                  ),
                                                  new Text("   ENVIANDO MENSAGEM!"),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        print("USUSARIO LOGADO");

                                        final queryN1 = await Firestore.instance
                                            .collection('users')
                                            .document(user.uid)
                                            .collection('cell number')
                                            .document(user.uid)
                                            .get()
                                            .then((DocumentSnapshot) => (DocumentSnapshot
                                            .data['numberOne']
                                            .toString()));
                                        if (queryN1 != null) {
                                          recipents.add(queryN1);
                                        }
                                        final queryN2 = await Firestore.instance
                                            .collection('users')
                                            .document(user.uid)
                                            .collection('cell number')
                                            .document(user.uid)
                                            .get()
                                            .then((DocumentSnapshot) => (DocumentSnapshot
                                            .data['numberTwo']
                                            .toString()));
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
                                            .then((DocumentSnapshot) => (DocumentSnapshot
                                            .data['numberFour']
                                            .toString()));
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
                                            .then((DocumentSnapshot) => (DocumentSnapshot
                                            .data['numberFive']
                                            .toString()));
                                        if (queryN5 != null) {
                                          print(queryN5);
                                          recipents.add(queryN5);
                                        }

                                        await _getCurrentLocation();
                                        print("URL FINAL: $local");

                                        _sendSMS(messageSMS, recipents, context);
                                      }
                                      if (user == null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              title: new Text("Usuário não Autenticado!"),
                                              content: new Text(
                                                  "Por Favor Logue no sistema para ter acesso a função SOS!"),
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
                                    }),
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
                          ]),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 50)),
                    Container(
                      width: constraints.maxWidth * .9,
                      height: constraints.maxHeight * .1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FloatingActionButton(
                            child: Icon(
                              Icons.my_location,
                              color: Color.fromRGBO(1, 84, 164, 1),
                              size: 50,
                            ),
                            backgroundColor: Color.fromRGBO(134, 203, 232, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(100.0),
                                side: BorderSide(
                                    color: Colors.transparent,
                                    //Color.fromRGBO(127, 5, 118, 1),
                                    style: BorderStyle.solid,
                                    width: 200)),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    elevation: 30.0,
                                    backgroundColor:
                                    Color.fromRGBO(252, 239, 246, 1),
                                    child: new Row(
                                      children: [
                                        new CircularProgressIndicator(
                                          backgroundColor:
                                          Color.fromRGBO(119, 1, 108, 1),
                                          strokeWidth: 10,
                                        ),
                                        new Text(
                                            "   Aguarde estamos gerando sua localização"),
                                      ],
                                    ),
                                  );
                                },
                              );
                              await _getCurrentLocation();
                              Navigator.of(context, rootNavigator: true).pop();
                               share();
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
            }))),
          ],
        ),
      ),
    );
  }
}
