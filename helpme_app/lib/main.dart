import 'package:flutter/material.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Screens/home_screen.dart';

void main() => runApp(MyApp());

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
