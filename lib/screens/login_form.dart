// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/needed/navigation_home_screen.dart';
import 'package:vnr_connect/screens/animated_login.dart';
import 'package:vnr_connect/screens/email_verification.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {

  @override
  void initState(){
    super.initState();
     reload();
  }
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errstring = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
 

  Future<void> reload() async {
    user!.reload();
  }

  @override
  Widget build(BuildContext context) {

    if (FirebaseAuth.instance.currentUser != null && !user!.emailVerified) {
      return EmailVerificationScreen();
    }
    if (FirebaseAuth.instance.currentUser != null && user!.emailVerified) {
      return NavigationHomeScreen();
    }
    return AnimatedLogin();
    // return Scaffold(
    //     appBar: AppBar(
    //         backgroundColor: Colors.lightBlueAccent,
    //         title: const Text('VNR CONNECT'),
    //         centerTitle: true,
    //         actions: [
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => const RegistrationIntro()),
    //                 );
    //               },
    //               child: Text("Register",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ))),
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => const LoginIntro()),
    //                 );
    //               },
    //               child: Text("Login",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ))),
    //         ]),
    //     body: SizedBox(
    //       width: 570,
    //       //margin: EdgeInsets.symmetric(horizontal: 400, vertical: 100),
    //       child: Form(
    //         autovalidateMode: AutovalidateMode.always,
    //         key: _loginFormKey,
    //         child: Padding(
    //           padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
    //           child: Column(children: <Widget>[
    //             TextFormField(
    //               controller: email,
    //               decoration: const InputDecoration(
    //                   icon: Icon(Icons.email),
    //                   hintText: 'Enter your college Email ID',
    //                   labelText: 'Email'),
    //               onChanged: (value) {
    //                 setState(() {
    //                   errstring = "";
    //                 });
    //               },
    //               validator: (value) {
    //                 if (value!.isEmpty) return "Required";
    //                 if (!value.endsWith("@gmail.com")) {
    //                   return "not a vaild email";
    //                 }

    //                 return null;
    //               },
    //             ),
    //             TextFormField(
    //               controller: password,
    //               obscureText: true,
    //               decoration: const InputDecoration(
    //                   icon: Icon(Icons.password),
    //                   hintText: 'Enter your Password',
    //                   labelText: 'Password'),
    //               onChanged: (value) {
    //                 setState(() {
    //                   errstring = "";
    //                 });
    //               },
    //               validator: (value) {
    //                 if (value!.isEmpty) {
    //                   return "required";
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //             ),
    //             Container(
    //               margin: EdgeInsets.all(20),
    //               child: TextButton(
    //                 style: TextButton.styleFrom(
    //                   backgroundColor: Colors.lightBlueAccent,
    //                 ),
    //                 onPressed: () async {
    //                   if(_loginFormKey.currentState!.validate())
    //                   {

                      
    //                   dynamic result = await AuthService()
    //                       .signInWithEmailAndPassword(
    //                           email.text, password.text);

    //                   if (result) {
    //                     if (!mounted) return;
    //                     Navigator.of(context).pop();
    //                     Navigator.push(context,
    //                         MaterialPageRoute(builder: (context) => Home()));
    //                   } else {
    //                     setState(() {
    //                       errstring = 'Password or email is incorrect';
    //                     });
    //                   }
    //                   }
    //                 },
    //                 child: Text(
    //                   "Login",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Text(errstring),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text("Not have an account ?"),
    //                 TextButton(
    //                   child: Text("Register"),
    //                   onPressed: () {
    //                     Navigator.push(context,
    //                         MaterialPageRoute(builder: (context) {
    //                       return RegistrationForm();
    //                     }));
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ]),
    //         ),
    //       ),
    //     ));
  }
}
