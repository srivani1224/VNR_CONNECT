import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [
        Text("VNR CONNECT"),
        TextButton(onPressed: null, child: Text("Register")),
        TextButton(onPressed: null, child: Text("Login"))
      ]),
    );
  }
}
