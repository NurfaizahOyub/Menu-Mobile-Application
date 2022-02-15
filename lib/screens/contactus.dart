import 'package:contactus/contactus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mainscreen.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Us",
          ),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: _signOut),
          ],
        ),
        backgroundColor: Colors.teal,
        body: Center(
          child: ContactUs(
            email: 'fastfood@gmail.com',
            companyName: 'Fast Food',
            phoneNumber: '0122447232',
            tagLine: 'Fast Food is Fast',
            twitterHandle: 'Fast_Food',
            instagram: 'Fast_Food',
          ),
        ));
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  runApp(new MaterialApp(
    home: new MainScreen(),
  ));
}
