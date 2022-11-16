// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CreativeArtsMembers extends StatefulWidget {
  const CreativeArtsMembers({super.key});

  @override
  CreativeArtsMembersState createState() => CreativeArtsMembersState();
}

class CreativeArtsMembersState extends State<CreativeArtsMembers> {
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
