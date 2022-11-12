// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/login_intro.dart';

class RegistrationIntro extends StatefulWidget {
  const RegistrationIntro({super.key});

  @override
  RegistrationIntroState createState() => RegistrationIntroState();
}

class RegistrationIntroState extends State<RegistrationIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('VNR CONNECT'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationIntro()),
                  );
                },
                child: Text("Register",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginIntro()),
                  );
                },
                child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ]),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: const Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 40),
                        child: Text("Register as Organizer/Head"),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: const Card(
                      color: Colors.lightBlueAccent,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 40),
                        child: Text("Register as VNR Student/Faculty"),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
