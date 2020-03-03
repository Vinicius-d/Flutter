import 'package:flutter/material.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Screens/home_screen.dart';

void main() => runApp(MyApp());

_launchURL() async {
  const url = 'http://cvvweb.mysuite1.com.br/client/chatan.php?h=&inf=&lfa=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ScopedModel<UserModel>(
      model: UserModel(

      ),

      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HelpME',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
