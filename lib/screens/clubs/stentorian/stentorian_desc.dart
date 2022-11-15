// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StentorianDesc extends StatefulWidget {
  const StentorianDesc({super.key});

  @override
  StentorianDescState createState() => StentorianDescState();
}

class StentorianDescState extends State<StentorianDesc> {
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
