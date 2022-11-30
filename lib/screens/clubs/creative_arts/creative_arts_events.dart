// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CreativeArtsEvents extends StatefulWidget {
  const CreativeArtsEvents({super.key});

  @override
  CreativeArtsEventsState createState() => CreativeArtsEventsState();
}

class CreativeArtsEventsState extends State<CreativeArtsEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('VNR CONNECT'),
          centerTitle: true,
          leading: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            ),
            icon: Icon(Icons.menu),
            label: Text(""),
            onPressed: () {},
          ),
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
