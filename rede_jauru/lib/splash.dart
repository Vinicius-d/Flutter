import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.pushReplacement(

      context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: LayoutBuilder(builder: (_, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth *.9,
                        height: constraints.maxHeight*.9,
                        child: new  Center(
                                child: Container(
                                  width:  400,
                                  height: 400,
                                  child: Image.asset("assets/images/logo-redejauru.png"),
                                ),
                              ),
                            )
                          ],



                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
