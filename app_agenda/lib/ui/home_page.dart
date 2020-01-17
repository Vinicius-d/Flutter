import 'dart:io';

import 'package:app_agenda/helpers/contats_helpers.dart';
import 'package:app_agenda/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();


  /*@override
  void initState() {
    super.initState();
    Contact c= Contact();
    c.name = "vinidesconsi";
    c.email ="vdesconsi@gmail.com";
    c.phone ="56594818851";
    c.img = "imgtzr";
    helper.saveContact(c);
    helper.getAllContact().then((List){
      print(List);
    });
  }*/

  @override
  void initState() {
    super.initState();
    _gatAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != null ?
                      FileImage(File(contacts[index].img)) :
                      AssetImage("image/person.png")
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? "",
                      style: TextStyle(fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(contacts[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],

                ),
              )
            ],
          ),)
        ,
      ),
      onTap: (){
        _showContactPage(contact: contacts[index]);
      }
      ,
    );
  }
    void _showContactPage({Contact contact}) async{
    final recContact = await Navigator.push(context,
    MaterialPageRoute(builder: (context) => ContactPage(contact: contact,))
    );
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);

      }
      else{
        await helper.saveContact(recContact);
      }
      _gatAllContacts();
    }
    }
    void _gatAllContacts(){
      helper.getAllContact().then((list) {
        setState(() {
          contacts = list;
        });
      });
    }
}
