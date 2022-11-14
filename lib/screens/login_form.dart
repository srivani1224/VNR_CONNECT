// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/login_intro.dart';
import 'package:vnr_connect/screens/registration_intro.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

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
                      MaterialPageRoute(
                          builder: (context) => const LoginIntro()),
                    );
                  },
                  child: Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ]),
        body: Container(
          width: 570,
          margin: EdgeInsets.symmetric(horizontal: 400, vertical: 100),
          child: Form(
            key: _loginFormKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter your college Email ID',
                    labelText: 'Email'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Enter your Password',
                    labelText: 'Password'),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  onPressed: null,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
