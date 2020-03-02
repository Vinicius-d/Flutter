import 'package:flutter/material.dart';
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelpME',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
