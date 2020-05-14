import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Screens/home_screen.dart';
void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('Bem-Vindo ao\n'
                          '   HELPE-ME',
            style: GoogleFonts.oswald(
                fontSize: 20,
                color: Color.fromRGBO(1, 84, 164, 1),
                fontWeight: FontWeight.w700)),
        image: new Image.network('https://rs618.pbsrc.com/albums/tt265/davejarrett/smileys/animatedminiongifscream_zps09547991.gif~c200'),
        backgroundColor:  Color.fromRGBO(252, 239, 246, 1),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,

        loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(

      model: UserModel(

      ),

      child: MaterialApp(
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
//void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
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
}*/
