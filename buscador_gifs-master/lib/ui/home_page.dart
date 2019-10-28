import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gif_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;
    if (_search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=YH9wi1wQj72SHbMaXfGmVCS7GPw1KsJa&limit=20&rating=G");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=YH9wi1wQj72SHbMaXfGmVCS7GPw1KsJa&q=$_search&limit=20&offset=$_offset&rating=G&lang=en");
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map){});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(18),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Pesquisa",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
                onSubmitted: (text){
                  setState(() {
                    _search = text;
                  });
                },
              )),
          Expanded(
            child: FutureBuilder(
                future: _getGifs(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createGifTable(context, snapshot);
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,

        ),
        itemCount: snapshot.data["data"].length ,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"]),
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> GifPage(snapshot.data["data"][index]))
              );
            },

          );
        }
    );
    }
}



