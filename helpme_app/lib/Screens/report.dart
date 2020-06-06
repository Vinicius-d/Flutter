import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_correios/flutter_correios.dart';
import 'package:flutter_correios/model/resultado_cep.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Models/user_model.dart';
import 'package:mask_shifter/mask_shifter.dart';
import 'package:scoped_model/scoped_model.dart';

class relatorio extends StatefulWidget {
  @override
  _report createState() => _report();
}

class _report extends State<relatorio> {
  final _cepController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _valueState = false;
  bool _valueCity = false;
  bool _valueNeigh = false;
  String neigh;
  String city;
  String state;
  int cont = 0;

  anddress(String NCEP) async {
    final FlutterCorreios fc = FlutterCorreios();
    ResultadoCEP resultado = await fc.consultarCEP(cep: "$NCEP");
    neigh = ("${resultado.bairro}");
    city = ("${resultado.cidade}");
    state = ("${resultado.estado}");
    await busca();
  }

  busca() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('address').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    //documents.forEach((data) => est =  data.data['ESTADO']);
    var map = Map();

    documents.forEach((element) {
      if (!map.containsKey(element)) {
        if (_valueState == true &&
            _valueCity == false &&
            _valueNeigh == false) {
          if (state == element.data['ESTADO']) {
            cont++;
            city = "";
            neigh = '';
          }
        }
        if (_valueState == true && _valueCity == true && _valueNeigh == false) {
          if (state == element.data['ESTADO'] &&
              city == element.data['CIDADE']) {
            cont++;
            neigh = '';
          }
        }
        if (_valueState == true && _valueCity == true && _valueNeigh == true) {
          if (state == element.data['ESTADO'] &&
              city == element.data['CIDADE'] &&
              neigh == element.data['BAIRRO']) {
            cont++;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final _pageController = PageController();
    return Scaffold(
        key: _scaffoldKey,
        appBar: GradientAppBar(
          title: Text("Relatório"),
          centerTitle: true,
          backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
          backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
        ),
        //drawer: CustomDrawer(_pageController),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _cepController,
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XXXXX-XXX", maskTWO: "XXXXXXXXX"),
                  ],
                  decoration: InputDecoration(hintText: "CEP"),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (text) {
                    if (text.isEmpty) return "CEP inválido!";
                  },
                ),
                CheckboxListTile(
                    value: _valueState,
                    title: Text('Busca por Estado'),
                    onChanged: (bool newValue) {
                      setState(() {
                        _valueState = newValue;
                      });
                    }),
                CheckboxListTile(
                    value: _valueCity,
                    title: Text('Busca por Cidade'),
                    onChanged: (bool newValue) {
                      setState(() {
                        _valueCity = newValue;
                      });
                    }),
                CheckboxListTile(
                    value: _valueNeigh,
                    title: Text('Busca por Bairro'),
                    onChanged: (bool newValue) {
                      setState(() {
                        _valueNeigh = newValue;
                      });
                    }),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                      child: Text("Buscar",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      textColor: Colors.white,
                      color: Color.fromRGBO(165, 88, 157, 1),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          cont = 0;
                          String cep = _cepController.text;
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                            duration: new Duration(seconds: 2),
                            content: new Row(
                              children: <Widget>[
                                new CircularProgressIndicator(),
                                new Text("  please wait...")
                              ],
                            ),
                          ));
                          await anddress(cep);
                          if (_valueState == false &&
                              _valueCity == true &&
                              _valueNeigh == false) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => FancyDialog(
                                      title: "Ops!",
                                      descreption:
                                          " Você não pode selecionar cidade sem ter selecionado o estado ",
                                      gifPath: FancyGif.MOVE_FORWARD,
                                    ));
                          }
                          if (_valueState == false &&
                              _valueCity == true &&
                              _valueNeigh == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                title: "Ops!",
                                descreption:
                                    " Você não pode selecionar cidade e bairro sem ter selecionado o estado ",
                                gifPath: FancyGif.MOVE_FORWARD,
                              ),
                            );
                          }

                          if (_valueState == false &&
                              _valueCity == false &&
                              _valueNeigh == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                title: "Ops!",
                                descreption:
                                    " Você não pode selecionar bairro sem ter selecionado o cidade e estado antes",
                                gifPath: FancyGif.MOVE_FORWARD,
                              ),
                            );
                          }

                          if (_valueState == true &&
                              _valueCity == false &&
                              _valueNeigh == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => FancyDialog(
                                title: "Ops!",
                                descreption:
                                    " Você não pode selecionar bairro e estado sem ter selecionado a cidade antes",
                                gifPath: FancyGif.MOVE_FORWARD,
                              ),
                            );
                          } else if (_valueState == true) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => FancyDialog(
                                      title: "Relatório!",
                                      descreption: "Filtros Selecionados:"
                                          "\n$state, "
                                          "$city\n"
                                          "$neigh\n"
                                          "Incidência: $cont ",
                                      gifPath: FancyGif.CHECK_MAIL,
                                    ));
                          }
                        }
                      }),
                ),
              ],
            ),
          );
        }));
  }
}
