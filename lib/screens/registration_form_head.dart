// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/data_models/checkbox_model.dart';
import 'package:vnr_connect/screens/login_intro.dart';
import 'package:vnr_connect/screens/registration_intro.dart';

class RegistrationFormHead extends StatefulWidget {
  const RegistrationFormHead({super.key});

  @override
  RegistrationFormHeadState createState() => RegistrationFormHeadState();
}

class RegistrationFormHeadState extends State<RegistrationFormHead> {
  final _registrationFormHeadKey = GlobalKey<FormState>();
  final List<CheckBoxModel> _items = [
    CheckBoxModel("Live Wire — The Dance Club", false),
    CheckBoxModel("Crescendo — The Music Club", false),
    CheckBoxModel("Creative Arts — The Arts Club", false),
    CheckBoxModel("VJ Teatro — Short film-making Club", false),
    CheckBoxModel("Scintillate — Photography Club", false),
    CheckBoxModel("Stentorian — English Literary Club", false),
    CheckBoxModel(
        "Vignana Jyothi Sahiti Vanam — The Telugu Literary Club", false),
    CheckBoxModel("Dramatrix — The Drama Club", false),
    CheckBoxModel("N Army — Nature’s Army", false),
    CheckBoxModel("SF - Student Force", false),
    CheckBoxModel("NSS - National Service Scheme", false),
    CheckBoxModel("CSI - Computer Society of India", false),
    CheckBoxModel("ACM - Association for Computing Machinery's", false),
    CheckBoxModel(
        "IETE - Institute of Electronics and Telecommunications Engineers",
        false),
    CheckBoxModel("SAE - Society of Automotive Engineers", false),
    CheckBoxModel("ISTE - Indian Society for Technical Education", false),
    CheckBoxModel(
        "IEEE - Institute of Electrical and Electronics Engineers", false),
    CheckBoxModel("ISOI - Instrument Society of India", false),
    CheckBoxModel("ASME - The American Society of Mechanical Engineers", false),
    CheckBoxModel("IEI - Institution of Engineers", false),
    CheckBoxModel("CEA -  Civil Engineering Association", false),
  ];

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
            key: _registrationFormHeadKey,
            child: Column(children: <Widget>[
              TextFormField(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Enter your Password',
                    labelText: 'Password'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Clubs, Student Chapters, Fests that you want to be head :",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ListView(
                    children: _items
                        .map((CheckBoxModel item) => CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(item.title),
                              value: item.isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  item.isChecked = value!;
                                });
                              },
                            ))
                        .toList()),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  onPressed: null,
                  child: Text(
                    "Send Request",
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
