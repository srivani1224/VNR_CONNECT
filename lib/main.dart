import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vnr connect',
      home: Scaffold(
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
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
      ),
    );
  }
}
