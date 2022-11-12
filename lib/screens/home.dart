import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //backgroundColor: Colors.lightBlueAccent,
          title: const Text('VNR CONNECT'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: null,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: const Text("Register")),
            TextButton(
                onPressed: null,
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
                child: const Text("Login")),
          ]),
    );
  }
}
