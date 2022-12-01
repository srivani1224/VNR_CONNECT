

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/after_login_vnr_student/home_clubs.dart';
import 'package:vnr_connect/screens/home.dart';
import 'package:vnr_connect/screens/login_form.dart';


void main(){  
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initialization ,
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return MaterialApp(
            home: Scaffold(appBar:AppBar(
              title: const Text("VNR CONNECT"),
            )),
          );
        }
    else if(snapshot.hasError)
    {
      return MaterialApp(
        home: Scaffold(appBar: AppBar(title: const Text("error"),
        )),
      );
    }
    
    return const MaterialApp(
      title: 'vnr connect',
      home: LoginForm(),
    );
    });
  }
}

class MyAppScreen extends StatelessWidget {
  const MyAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(250),
        child: Column(
          children: <Widget>[
            const Text(
              "VNR CONNECT",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("clubMembersCreativeArts")
                    .doc("eqDZoEMBaXqM2wiaQcRa")
                    .set({"Name": "Srivani Reddy"})
                    .then((value) => {const Home()})
                    .catchError((onError) {
                      const Home();
                    });

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Home()),
                // );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
              ),
              child: const Text("Explore"),
            )
          ],
        ),
      )),
    );
  }
}
