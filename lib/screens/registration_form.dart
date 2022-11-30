// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/login_intro.dart';
import 'package:vnr_connect/screens/registration_intro.dart';
import 'package:vnr_connect/service/authenticate.dart';
import 'package:vnr_connect/screens/home.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _registrationFormKey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {

    createDialogBox(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("email is already registered or email is incorrect"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("click to change"))
              ],
            );
          });
    }


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
        body: Center(
          child: SizedBox(
            width: 570,
           // margin: EdgeInsets.symmetric(horizontal: 400, vertical: 100),
            child: Form(
              key: _registrationFormKey,
              child: Center(
                child: Column(children: <Widget>[
                  TextFormField(
                    controller:email,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter your college Email ID',
                        labelText: 'Email'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your Name',
                        labelText: 'Name'),
                  ),
                  TextFormField(
                    controller:password,
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
                      onPressed:  () async {
                        dynamic result = await AuthService()
                            .registerWithEmailAndPass(
                                email.text, password.text);
                        if (result) {
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } else {
                          if (!mounted) return;
                          createDialogBox(context);
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                
                ]),
              ),
            ),
          ),
        ));
  }
}
