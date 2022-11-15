// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CrescendoDesc extends StatefulWidget {
  const CrescendoDesc({super.key});

  @override
  CrescendoDescState createState() => CrescendoDescState();
}

class CrescendoDescState extends State<CrescendoDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('VNR CONNECT'),
          centerTitle: true,
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              onPressed: () {},
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.person),
              label: Text("Profile"),
              onPressed: () {},
            ),
          ]),
      body: Center(),
    );
  }
}
