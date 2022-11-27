import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vnr_connect/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'vnr connect',
      home: MyAppScreen(),
    );
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
