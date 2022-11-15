import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/after_login_vnr_student/home_clubs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'vnr connect',
      home: Home(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeClubs()),
                );
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
