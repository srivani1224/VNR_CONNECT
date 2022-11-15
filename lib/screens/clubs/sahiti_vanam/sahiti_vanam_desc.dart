// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SahitiVanamDesc extends StatefulWidget {
  const SahitiVanamDesc({super.key});

  @override
  SahitiVanamDescState createState() => SahitiVanamDescState();
}

class SahitiVanamDescState extends State<SahitiVanamDesc> {
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