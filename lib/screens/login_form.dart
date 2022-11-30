// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/home.dart';
import 'package:vnr_connect/screens/login_intro.dart';
import 'package:vnr_connect/screens/registration_form.dart';
import 'package:vnr_connect/screens/registration_intro.dart';
import 'package:vnr_connect/service/authenticate.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
TextEditingController email=TextEditingController();
TextEditingController password = TextEditingController();

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
        body: SizedBox(
          width: 570,
          //margin: EdgeInsets.symmetric(horizontal: 400, vertical: 100),
          child: Form(
            key: _loginFormKey,
            child: Column(children: <Widget>[
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Enter your college Email ID',
                    labelText: 'Email'),
              ),
              TextFormField(
                controller: password,
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
                  onPressed: ()async {
                    dynamic result=await AuthService().signInWithEmailAndPassword(email.text, password.text);
                    if(result){
                      if(!mounted) return;
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not have an account ?"),
                  TextButton(
                    child: Text("Register"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegistrationForm();
                      }));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
