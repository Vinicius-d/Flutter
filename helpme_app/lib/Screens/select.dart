import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Select extends StatefulWidget {
  @override
  _SelectState createState() => _SelectState();
}

busca() async {


  final QuerySnapshot result = await Firestore.instance.collection('address').getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  //documents.forEach((data) => est =  data.data['ESTADO']);
  var map = Map();
var vem='RS';
  var vem2='Santa Maria';
  var vem3='Centro';

int cont=0;
  documents.forEach((element) {
    if(!map.containsKey(element)) {
      if(vem ==element.data['ESTADO']&& vem2== element.data['CIDADE']&& vem3== element.data['BAIRRO'])
        cont++;
      //print(element.data['CIDADE']);
    } else {
      map[element] +=1;
    }
  });

  print(cont);

  String est='';
 //documents.forEach((data) => print(data.data['CIDADE']));



  for(int i=0; i<documents.length; i++){

      //print(i);
    }






}



class _SelectState extends State<Select> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter FlatButton - tutorialkart.com'),
          ),
          body: Center(child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Login'),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: FlatButton(
                child: Text('Login'),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () async {
                  await busca();

                },
              ),
            ),
          ]))),
    );
  }
}